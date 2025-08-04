import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:mimemo/common/utils/debouncer.dart';
import 'package:mimemo/common/utils/logger.dart';
import 'package:mimemo/core/base/bases.dart';
import 'package:mimemo/models/entities/current_conditions/current_conditions.dart';
import 'package:mimemo/models/entities/position_info/position_info.dart';
import 'package:mimemo/models/entities/search_location_response/search_location_response.dart';
import 'package:mimemo/models/enums/load_status.dart';
import 'package:mimemo/repositories/current_condition_repository.dart';
import 'package:mimemo/repositories/position_repository.dart';
import 'package:mimemo/repositories/search_location_repository.dart';
import 'package:mimemo/services/geolocation_service.dart';

part 'search_location_state.dart';

class SearchLocationCubit extends BaseCubit<SearchLocationState> {
  SearchLocationCubit({
    required SearchLocationRepository searchLocationRepository,
    required PositionRepository positionRepository,
    required GeoLocationService geoLocationService,
    required CurrentConditionRepository currentConditionRepository,
  }) : _searchLocationRepository = searchLocationRepository,
       _positionRepository = positionRepository,
       _geoLocationService = geoLocationService,
       _currentConditionRepository = currentConditionRepository,
       super(const SearchLocationState());

  final Debouncer _debouncer = Debouncer();
  final SearchLocationRepository _searchLocationRepository;
  final PositionRepository _positionRepository;
  final GeoLocationService _geoLocationService;
  final CurrentConditionRepository _currentConditionRepository;

  Future<void> init() async {
    try {
      unawaited(getRecentPositions());
      unawaited(getCurrentPositionInfo());
    } on Exception catch (e, s) {
      logger.e(e, stackTrace: s);
    }
  }

  Future<void> getRecentPositions() async {
    try {
      final recentPositions = await _positionRepository.getSavedRecentPositions();
      emit(state.copyWith(recentPositions: recentPositions));
    } on Exception {
      rethrow;
    }
  }

  Future<void> getCurrentPositionInfo() async {
    emit(state.copyWith(currentPositionStatus: LoadStatus.loading));
    try {
      final coordinates = await _geoLocationService.getCurrentPosition();
      final currentPosition = await _positionRepository.getGeoPosition(
        lat: coordinates.latitude,
        long: coordinates.longitude,
      );
      final currentConditions = await _currentConditionRepository.getCurrentConditions(
        currentPosition.key ?? '',
      );
      emit(
        state.copyWith(
          currentPosition: currentPosition,
          currentPositionConditions: currentConditions,
          currentPositionStatus: LoadStatus.success,
        ),
      );
    } on Exception {
      emit(state.copyWith(currentPositionStatus: LoadStatus.failure));
      rethrow;
    }
  }

  Future<void> clearRecentPositions() async {
    await _positionRepository.clearRecentPositions();
    emit(state.copyWith(recentPositions: []));
  }

  void toggleIsSearching(bool isSearching) {
    if (isSearching != state.isSearching) {
      emit(
        state.copyWith(
          isSearching: isSearching,
          searchLocationResponse: isSearching ? state.searchLocationResponse : null,
        ),
      );
    }
  }

  Future<void> searchLocation(String query) async {
    _debouncer.run(
      () async {
        if (query.isEmpty) return;
        try {
          final searchResponse = await _searchLocationRepository.searchLocation(query);
          emit(state.copyWith(searchLocationResponse: searchResponse));
        } on Exception catch (e) {
          logger.e(e);
        }
      },
    );
  }
}
