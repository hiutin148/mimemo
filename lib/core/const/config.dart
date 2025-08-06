abstract final class Config {
  static const String apiUrl = String.fromEnvironment('API_URL');
  static const apiKey = String.fromEnvironment('API_KEY');
  static const radarLocationUrl = String.fromEnvironment('RADAR_LOCATION_URL');
  static const radarLocationKey = String.fromEnvironment('RADAR_LOCATION_KEY');
  static const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');
}
