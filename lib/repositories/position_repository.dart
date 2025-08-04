import 'dart:convert';

import 'package:mimemo/common/utils/logger.dart';
import 'package:mimemo/models/entities/position_info/position_info.dart';
import 'package:mimemo/services/api/api_client.dart';
import 'package:mimemo/services/shared_preference_service.dart';

abstract class PositionRepository {
  Future<PositionInfo> getGeoPosition({required double lat, required double long});

  Future<PositionInfo> getPositionByLocationKey(String locationKey);

  Future<String?> getSavedLocationKey();

  Future<bool> setSavedLocationKey(String key);

  Future<bool> removeSavedLocationKey();

  Future<bool> setSavedLatLong(double lat, double long);

  Future<(double lat, double long)?> getSavedLatLong();

  Future<List<PositionInfo>> getSavedRecentPositions();

  Future<void> insertRecentPosition(PositionInfo position);

  Future<void> clearRecentPositions();
}

class PositionRepositoryImpl extends PositionRepository {
  PositionRepositoryImpl({required this.apiClient, required this.sharedPreferencesService});

  final SharedPreferencesService sharedPreferencesService;

  final ApiClient apiClient;

  final savedLocationKeyKey = 'savedLocationKey';
  final savedLatLongKey = 'savedLatLong';
  final savedRecentPositionKey = 'savedRecentPosition';

  @override
  Future<PositionInfo> getGeoPosition({required double lat, required double long}) {
    final q = '$lat,$long';
    return apiClient.getGeoPosition(q);
  }

  @override
  Future<PositionInfo> getPositionByLocationKey(String locationKey) {
    return apiClient.getPositionByLocationKey(locationKey);
  }

  @override
  Future<String?> getSavedLocationKey() {
    return sharedPreferencesService.getString(savedLocationKeyKey, '');
  }

  @override
  Future<bool> setSavedLocationKey(String key) {
    return sharedPreferencesService.setString(savedLocationKeyKey, key);
  }

  @override
  Future<bool> setSavedLatLong(double lat, double long) {
    final latLongMap = {'lat': lat, 'long': long};
    final latLongString = jsonEncode(latLongMap);
    return sharedPreferencesService.setString(savedLatLongKey, latLongString);
  }

  @override
  Future<(double, double)?> getSavedLatLong() async {
    try {
      final latLongString = await sharedPreferencesService.getString(savedLatLongKey, '');

      if (latLongString?.isEmpty ?? true) {
        return null;
      }

      final dynamic decodedJson = jsonDecode(latLongString!);

      if (decodedJson is! Map<String, dynamic>) {
        return null;
      }

      final latLongMap = decodedJson;

      final dynamic latValue = latLongMap['lat'];
      final dynamic longValue = latLongMap['long'];

      if (latValue == null || longValue == null) {
        return null;
      }

      final lat = _toDouble(latValue);
      final long = _toDouble(longValue);

      if (lat == null || long == null) {
        return null;
      }

      return (lat, long);
    } on Exception catch (e) {
      logger.e(e);
      return null;
    }
  }

  double? _toDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      return double.tryParse(value);
    }
    return null;
  }

  @override
  Future<bool> removeSavedLocationKey() {
    return sharedPreferencesService.remove(savedLocationKeyKey);
  }

  @override
  Future<List<PositionInfo>> getSavedRecentPositions() async {
    try {
      final recentPositionString = await sharedPreferencesService.getString(savedRecentPositionKey);

      if (recentPositionString?.isEmpty ?? true) {
        return [];
      }

      final dynamic decodedJson = jsonDecode(recentPositionString!);

      if (decodedJson is! List) {
        return [];
      }

      return decodedJson
          .whereType<Map<String, dynamic>>()
          .map((item) {
            try {
              return PositionInfo.fromJson(item);
            } on Exception catch (e, s) {
              logger.e(e, stackTrace: s);
              return null;
            }
          })
          .where((position) => position != null)
          .cast<PositionInfo>()
          .toList();
    } on Exception catch (e, s) {
      logger.e(e, stackTrace: s);
      return [];
    }
  }

  @override
  Future<void> insertRecentPosition(PositionInfo position) async {
    try {
      final currentPositions = await getSavedRecentPositions();
      if (currentPositions.any((element) => element.key == position.key)) return;
      currentPositions.insert(0, position);

      final limitedPositions = currentPositions.take(5).toList();

      final jsonList = limitedPositions.map((pos) => pos.toJson()).toList();
      final jsonString = jsonEncode(jsonList);

      await sharedPreferencesService.setString(savedRecentPositionKey, jsonString);
    } on Exception catch (e, s) {
      logger.e('Error saving recent position: $e', stackTrace: s);
    }
  }

  @override
  Future<void> clearRecentPositions() async {
    await sharedPreferencesService.remove(savedRecentPositionKey);
  }
}
