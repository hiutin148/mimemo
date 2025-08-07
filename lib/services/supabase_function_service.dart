import 'package:mimemo/common/utils/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseFunctionService {
  Future<void> saveFcmToken(String fcmToken) async {
    try {
      await Supabase.instance.client.from('devices').upsert({'fcm_token': fcmToken});
    } on Exception catch (e) {
      logger.e('Error saving token to Supabase: $e');
    }
  }

  Future<void> saveLocationKey(String? locationKey, String token) async {
    try {
      if (locationKey == null) return;
      await Supabase.instance.client
          .from('devices')
          .update({'location_key': locationKey})
          .eq('fcm_token', token);
    } on Exception catch (e) {
      logger.e('Error saving location_key to Supabase: $e');
    }
  }
}
