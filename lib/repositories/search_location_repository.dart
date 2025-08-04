import 'dart:async';
import 'dart:convert';

import 'package:mimemo/models/entities/position_info/position_info.dart';
import 'package:mimemo/models/entities/search_location_response/search_location_response.dart';
import 'package:mimemo/services/api/dio_client.dart';
import 'package:mimemo/services/shared_preference_service.dart';

abstract class SearchLocationRepository {
  Future<List<PositionInfo>> getFavoriteLocations();

  Future<bool> addFavoriteLocation(PositionInfo positionInfo);

  Future<SearchLocationResponse?> searchLocation(String query);
}

class SearchLocationRepositoryImpl extends SearchLocationRepository {
  SearchLocationRepositoryImpl({
    required this.sharedPreferencesService,
    required this.dioClient,
  });

  final SharedPreferencesService sharedPreferencesService;
  final DioClient dioClient;

  final favoriteLocationKey = 'favoriteLocationKey';

  @override
  Future<bool> addFavoriteLocation(PositionInfo positionInfo) async {
    final currentFavoriteLocationsString = await sharedPreferencesService.getString(
      favoriteLocationKey,
    );
    if (currentFavoriteLocationsString != null) {
      final decoded = jsonDecode(currentFavoriteLocationsString);
      if (decoded is List) {
        final mapList = decoded.cast<Map<String, dynamic>>();
        final currentFavoriteLocations =
            mapList.map(PositionInfo.fromJson).whereType<PositionInfo>().toList()
              ..insert(0, positionInfo);
        if (currentFavoriteLocations.length > 10) {
          currentFavoriteLocations.removeLast();
        }
        return sharedPreferencesService.setString(
          favoriteLocationKey,
          jsonEncode(currentFavoriteLocations.map((e) => e.toJson()).toList()),
        );
      }
    } else {
      final favoriteLocations = [positionInfo];
      return sharedPreferencesService.setString(
        favoriteLocationKey,
        jsonEncode(favoriteLocations),
      );
    }
    return false;
  }

  @override
  Future<List<PositionInfo>> getFavoriteLocations() async {
    final currentFavoriteLocationsString = await sharedPreferencesService.getString(
      favoriteLocationKey,
    );
    if (currentFavoriteLocationsString != null) {
      final decoded = jsonDecode(currentFavoriteLocationsString);
      if (decoded is List) {
        final mapList = decoded.cast<Map<String, dynamic>>();
        final currentFavoriteLocations = mapList
            .map(PositionInfo.fromJson)
            .whereType<PositionInfo>()
            .toList();
        return currentFavoriteLocations;
      }
    }
    return [];
  }

  @override
  Future<SearchLocationResponse?> searchLocation(String query) {
    return dioClient.searchLocation(query);
  }
}
