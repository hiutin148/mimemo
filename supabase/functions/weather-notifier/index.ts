import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

// --- PHẦN 1: ĐỊNH NGHĨA VÀ HÀM HELPER CHO VIỆC XÁC THỰC ---

const SCOPES = ["https://www.googleapis.com/auth/firebase.messaging"];

// Custom JWT implementation cho Google Service Account
async function createJWT(serviceAccount: any, scopes: string[]): Promise<string> {
  const now = Math.floor(Date.now() / 1000);
  const iat = now;
  const exp = now + 3600; // 1 hour

  const header = {
    alg: "RS256",
    typ: "JWT",
  };

  const payload = {
    iss: serviceAccount.client_email,
    scope: scopes.join(" "),
    aud: "https://oauth2.googleapis.com/token",
    exp: exp,
    iat: iat,
  };

  const encodedHeader = btoa(JSON.stringify(header)).replace(/=/g, "").replace(/\+/g, "-").replace(/\//g, "_");
  const encodedPayload = btoa(JSON.stringify(payload)).replace(/=/g, "").replace(/\+/g, "-").replace(/\//g, "_");

  const message = `${encodedHeader}.${encodedPayload}`;
  
  const privateKeyPem = serviceAccount.private_key;
  const pemContents = privateKeyPem
    .replace("-----BEGIN PRIVATE KEY-----", "")
    .replace("-----END PRIVATE KEY-----", "")
    .replace(/\s/g, "");

  const keyData = Uint8Array.from(atob(pemContents), c => c.charCodeAt(0));

  const cryptoKey = await crypto.subtle.importKey(
    "pkcs8",
    keyData,
    { name: "RSASSA-PKCS1-v1_5", hash: "SHA-256" },
    false,
    ["sign"]
  );

  const signature = await crypto.subtle.sign(
    "RSASSA-PKCS1-v1_5",
    cryptoKey,
    new TextEncoder().encode(message)
  );

  const encodedSignature = btoa(String.fromCharCode(...new Uint8Array(signature)))
    .replace(/=/g, "")
    .replace(/\+/g, "-")
    .replace(/\//g, "_");

  return `${message}.${encodedSignature}`;
}

// Hàm lấy Google OAuth access token
async function getGoogleAccessToken(serviceAccount: any): Promise<string> {
  const jwt = await createJWT(serviceAccount, SCOPES);

  const response = await fetch("https://oauth2.googleapis.com/token", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: new URLSearchParams({
      grant_type: "urn:ietf:params:oauth:grant-type:jwt-bearer",
      assertion: jwt,
    }),
  });

  if (!response.ok) {
    const errorText = await response.text();
    throw new Error(`Failed to get access token: ${errorText}`);
  }

  const data = await response.json();
  return data.access_token;
}


// --- PHẦN 2: ĐỊNH NGHĨA INTERFACE VÀ CÁC HÀM HELPER NGHIỆP VỤ ---

interface WeatherAlert {
  Description?: { Localized?: string };
  Area?: Array<{ Summary?: string }>;
}

export interface CurrentWeather {
  LocalObservationDateTime?: string;
  EpochTime?: number;
  WeatherText?: string;
  WeatherIcon?: number;
  HasPrecipitation?: boolean;
  PrecipitationType?: string | null;
  IsDayTime?: boolean;

  Temperature?: Temperature;
  RealFeelTemperature?: TemperatureWithPhrase;
  RealFeelTemperatureShade?: TemperatureWithPhrase;
  ApparentTemperature?: TemperatureUnit;
  WindChillTemperature?: TemperatureUnit;
  WetBulbTemperature?: TemperatureUnit;
  WetBulbGlobeTemperature?: TemperatureUnit;
  DewPoint?: TemperatureUnit;

  RelativeHumidity?: number;
  IndoorRelativeHumidity?: number;

  Wind?: WindInfo;
  WindGust?: { Speed?: Speed };

  UVIndex?: number;
  UVIndexFloat?: number;
  UVIndexText?: string;

  Visibility?: Distance;
  ObstructionsToVisibility?: string;
  CloudCover?: number;
  Ceiling?: Distance;

  Pressure?: Pressure;
  PressureTendency?: {
    LocalizedText?: string;
    Code?: string;
  };

  Past24HourTemperatureDeparture?: TemperatureUnit;

  Precip1hr?: Precipitation;
  PrecipitationSummary?: {
    Precipitation?: Precipitation;
    PastHour?: Precipitation;
    Past3Hours?: Precipitation;
    Past6Hours?: Precipitation;
    Past9Hours?: Precipitation;
    Past12Hours?: Precipitation;
    Past18Hours?: Precipitation;
    Past24Hours?: Precipitation;
  };

  TemperatureSummary?: {
    Past6HourRange?: TemperatureRange;
    Past12HourRange?: TemperatureRange;
    Past24HourRange?: TemperatureRange;
  };

  MobileLink?: string;
  Link?: string;
}

// Sub interfaces
interface Temperature {
  Metric?: TemperatureUnit;
  Imperial?: TemperatureUnit;
}

interface TemperatureUnit {
  Value?: number;
  Unit?: string;
  UnitType?: number;
}

interface TemperatureWithPhrase extends TemperatureUnit {
  Phrase?: string;
}

interface WindInfo {
  Direction?: {
    Degrees?: number;
    Localized?: string;
    English?: string;
  };
  Speed?: Speed;
}

interface Speed {
  Metric?: {
    Value?: number;
    Unit?: string;
    UnitType?: number;
  };
  Imperial?: {
    Value?: number;
    Unit?: string;
    UnitType?: number;
  };
}

interface Distance {
  Metric?: {
    Value?: number;
    Unit?: string;
    UnitType?: number;
  };
  Imperial?: {
    Value?: number;
    Unit?: string;
    UnitType?: number;
  };
}

interface Pressure {
  Metric?: {
    Value?: number;
    Unit?: string;
    UnitType?: number;
  };
  Imperial?: {
    Value?: number;
    Unit?: string;
    UnitType?: number;
  };
}

interface Precipitation {
  Metric?: {
    Value?: number;
    Unit?: string;
    UnitType?: number;
  };
  Imperial?: {
    Value?: number;
    Unit?: string;
    UnitType?: number;
  };
}

interface TemperatureRange {
  Minimum?: TemperatureUnit;
  Maximum?: TemperatureUnit;
}

interface FCMMessage {
  message: {
    token: string;
    notification: { title: string; body: string };
    data: { [key: string]: string }; // Dùng [key: string] cho linh hoạt
    android?: { priority: string };
    apns?: { headers: { 'apns-priority': string } };
  };
}

function validateEnvironmentVariables() {
  const requiredVars = {
    SUPABASE_URL: Deno.env.get("SUPABASE_URL"),
    SUPABASE_SERVICE_ROLE_KEY: Deno.env.get("SUPABASE_SERVICE_ROLE_KEY"),
    WEATHER_API_KEY: Deno.env.get("WEATHER_API_KEY"),
    WEATHER_API_URL: Deno.env.get("WEATHER_API_URL"),
    FCM_SERVICE_ACCOUNT_JSON: Deno.env.get("FCM_SERVICE_ACCOUNT_JSON")
  };
  const missing = Object.entries(requiredVars).filter(([_, value]) => !value).map(([key]) => key);
  if (missing.length > 0) throw new Error(`Missing environment variables: ${missing.join(', ')}`);
  return requiredVars as Record<string, string>;
}

async function getUniqueLocationKeys(supabaseAdmin: any): Promise<string[]> {
  const { data, error } = await supabaseAdmin.from("devices").select("location_key").not("location_key", "is", null);
  if (error) throw new Error(`Error fetching locations: ${error.message}`);
  if (!data?.length) return [];
  return [...new Set((data as Array<{ location_key: string }>).map(d => d.location_key))];
}

async function fetchDataForLocation(
  locationKey: string,
  weatherApiUrl: string,
  weatherApiKey: string
): Promise<{ alerts: WeatherAlert[]; currentConditions: CurrentWeather[] }> {
    const alertsUrl = `${weatherApiUrl}/alerts/v1/${locationKey}?apikey=${weatherApiKey}&details=true`;
    const currentConditionsUrl = `${weatherApiUrl}/currentconditions/v1/${locationKey}?apikey=${weatherApiKey}&details=true&language=en-us&metric=true`;

    const [alertsResponse, conditionsResponse] = await Promise.all([ fetch(alertsUrl), fetch(currentConditionsUrl) ]);

    const alerts = alertsResponse.ok ? (await alertsResponse.json()) : [];
    const currentConditions = conditionsResponse.ok ? (await conditionsResponse.json()) : [];

    return {
        alerts: Array.isArray(alerts) ? alerts : [],
        currentConditions: Array.isArray(currentConditions) ? currentConditions : [],
    };
}

async function sendAlertNotifications(
  locationKey: string,
  alerts: WeatherAlert[],
  accessToken: string,
  projectId: string,
  supabaseAdmin: any
): Promise<void> {
    const { data: devices, error } = await supabaseAdmin.from("devices").select("fcm_token").eq("location_key", locationKey).not("fcm_token", "is", null);
    if (error || !devices?.length) {
        console.warn(`Không tìm thấy thiết bị để gửi cảnh báo cho vị trí ${locationKey}`);
        return;
    }

    const firstAlert = alerts[0];
    const alertTitle = firstAlert.Description?.Localized || "Cảnh báo thời tiết";
    const alertBody = firstAlert.Area?.[0]?.Summary || "Có cảnh báo mới cho khu vực của bạn.";
    const dataPayload = JSON.stringify(alerts);

    const notificationPromises = (devices as Array<{ fcm_token: string }>).map(device => {
        const fcmMessage: FCMMessage = {
            message: {
                token: device.fcm_token,
                notification: { title: alertTitle, body: alertBody },
                data: { alerts_payload: dataPayload },
                android: { priority: "high" },
                apns: { headers: { 'apns-priority': '10' } }
            },
        };
        return fetch(`https://fcm.googleapis.com/v1/projects/${projectId}/messages:send`, {
            method: "POST",
            headers: { Authorization: `Bearer ${accessToken}`, "Content-Type": "application/json" },
            body: JSON.stringify(fcmMessage),
        });
    });

    const results = await Promise.allSettled(notificationPromises);
    const successCount = results.filter(r => r.status === 'fulfilled').length;
    console.log(`Cảnh báo cho vị trí ${locationKey}: ${successCount}/${devices.length} gửi thành công.`);
}


async function sendCurrentWeatherNotification(
  locationKey: string,
  conditions: CurrentWeather,
  accessToken: string,
  projectId: string,
  supabaseAdmin: any
): Promise<void> {
    const { data: devices, error } = await supabaseAdmin.from("devices").select("fcm_token").eq("location_key", locationKey).not("fcm_token", "is", null);
    if (error || !devices?.length) {
        console.warn(`Not found weather information for ${locationKey}`);
        return;
    }

    const temp = conditions.Temperature?.Metric?.Value;
    const weatherText = conditions.WeatherText;
    const title = `Current weather conditions (${new Date().toLocaleDateString('vi-VN')})`;
    const body = `Hiện tại: ${temp}°C, ${weatherText}.`;
    const dataPayload = JSON.stringify(conditions);

    const notificationPromises = (devices as Array<{ fcm_token: string }>).map(device => {
        const fcmMessage: FCMMessage = {
            message: {
                token: device.fcm_token,
                notification: { title, body },
                data: { current_weather_payload: dataPayload },
            }
        };
        return fetch(`https://fcm.googleapis.com/v1/projects/${projectId}/messages:send`, {
            method: "POST",
            headers: { Authorization: `Bearer ${accessToken}`, "Content-Type": "application/json" },
            body: JSON.stringify(fcmMessage),
        });
    });

    const results = await Promise.allSettled(notificationPromises);
    const successCount = results.filter(r => r.status === 'fulfilled').length;
    console.log(`Daily weather condition fo ${locationKey}: ${successCount}/${devices.length} have sent successfully.`);
}


// --- PHẦN 3: MAIN EDGE FUNCTION ---

Deno.serve(async (_req) => {
  const startTime = Date.now();
  console.log("🚀 CRON JOB: Start...");

  try {
    const env = validateEnvironmentVariables();
    const supabaseAdmin = createClient(env.SUPABASE_URL, env.SUPABASE_SERVICE_ROLE_KEY);
    const uniqueLocationKeys = await getUniqueLocationKeys(supabaseAdmin);
    
    if (uniqueLocationKeys.length === 0) {
      return new Response("No location found.", { status: 200 });
    }

    console.log("🔐 Verifying Google FCM...");
    const serviceAccount = JSON.parse(env.FCM_SERVICE_ACCOUNT_JSON);
    const accessToken = await getGoogleAccessToken(serviceAccount);
    console.log("✅ Verified successfully.");

    const summary = {
      processed_locations: 0,
      locations_with_alerts: 0,
      locations_with_daily_forecast: 0,
    };

    for (const locationKey of uniqueLocationKeys) {
      try {
        console.log(`📍 Checking location: ${locationKey}`);
        const { alerts, currentConditions } = await fetchDataForLocation(
          locationKey, 
          env.WEATHER_API_URL, 
          env.WEATHER_API_KEY
        );
        summary.processed_locations++;

        // 1. Xử lý cảnh báo (luôn chạy)
        if (alerts.length > 0) {
          console.log(`⚠️ Found ${alerts.length} alert for ${locationKey}`);
          await sendAlertNotifications(locationKey, alerts, accessToken, serviceAccount.project_id, supabaseAdmin);
          summary.locations_with_alerts++;
        }

        // 2. Xử lý thông báo thời tiết hàng ngày (chỉ chạy vào một giờ nhất định)
        const currentHourUTC = new Date().getUTCHours();
        // TODO: Chỉnh sửa giờ bạn muốn gửi. 0h UTC là 7h sáng giờ Việt Nam.
        if (currentHourUTC === 0) {
            if (currentConditions.length > 0) {
                console.log(`☀️ Send daily weather conditions to ${locationKey}`);
                await sendCurrentWeatherNotification(locationKey, currentConditions[0], accessToken, serviceAccount.project_id, supabaseAdmin);
                summary.locations_with_daily_forecast++;
            }
        }
      } catch (error) {
        console.error(`❌ Error occurred ${locationKey}:`, error.message);
        continue;
      }
    }

    const duration = Date.now() - startTime;
    console.log("📊 CRON JOB Summary:", { ...summary, duration_ms: duration });
    console.log(`✅ CRON JOB will complete in ${duration}ms`);

    return new Response(JSON.stringify({ 
      success: true, 
      message: "Cron job have completed successfully",
      summary: { ...summary, duration_ms: duration } 
    }), {
      headers: { "Content-Type": "application/json" },
      status: 200
    });

  } catch (error) {
    const duration = Date.now() - startTime;
    console.error("💥 BIG ERROR:", error);
    
    return new Response(JSON.stringify({ 
      success: false,
      error: error.message,
      duration_ms: duration
    }), {
      headers: { "Content-Type": "application/json" },
      status: 500,
    });
  }
});