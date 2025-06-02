import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/models/entities/position_info/position_info.dart';
import 'package:mimemo/models/enums/load_status.dart';
import 'package:mimemo/repositories/position_repository.dart';
import 'package:mimemo/services/geolocation_service.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  final PositionRepository positionRepository;
  final GeoLocationService geoLocationService;

  MainCubit({
    required this.positionRepository,
    required this.geoLocationService,
  }) : super(MainState());

  Future<void> init() async {
    try {
      emit(state.copyWith(loadStatus: LoadStatus.loading));
      final position = await geoLocationService.getCurrentPosition();
      final positionInfo = await positionRepository.getGeoPosition(
        lat: position.latitude,
        long: position.longitude,
      );
      emit(
        state.copyWith(
          loadStatus: LoadStatus.success,
          positionInfo: positionInfo,
        ),
      );
    } catch (e) {
      print(e);
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }
}
