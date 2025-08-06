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
