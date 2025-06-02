import 'package:geolocator/geolocator.dart';

/// Custom exception for location-related errors
class LocationException implements Exception {
  final String message;
  final LocationErrorType type;

  const LocationException(this.message, this.type);

  @override
  String toString() => 'LocationException: $message';
}

/// Types of location errors
enum LocationErrorType {
  permissionDenied,
  permissionDeniedForever,
  serviceDisabled,
  timeout,
  unknown,
}

/// Simplified location service for getting current position
class GeoLocationService {

  /// Default location settings
  static const LocationSettings _defaultSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    timeLimit: Duration(seconds: 30),
  );

  /// Get current position with error handling
  Future<Position> getCurrentPosition() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw LocationException(
          'Location services are disabled',
          LocationErrorType.serviceDisabled,
        );
      }

      // Check and request permission
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw LocationException(
            'Location permission denied',
            LocationErrorType.permissionDenied,
          );
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw LocationException(
          'Location permissions permanently denied',
          LocationErrorType.permissionDeniedForever,
        );
      }

      // Get current position
      return await Geolocator.getCurrentPosition(
        locationSettings: _defaultSettings,
      );

    } catch (e) {
      if (e is LocationException) rethrow;
      throw LocationException(
        'Failed to get location: ${e.toString()}',
        LocationErrorType.unknown,
      );
    }
  }

  /// Open app settings for permissions
  Future<bool> openAppSettings() async {
    return await Geolocator.openAppSettings();
  }

  /// Open location settings
  Future<bool> openLocationSettings() async {
    return await Geolocator.openLocationSettings();
  }
}
