import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/common/utils/logger.dart';
import 'package:mimemo/generated/assets.dart';
import 'package:mimemo/models/entities/minute_color/minute_color.dart';
import 'package:mimemo/models/enums/app_map_type.dart';
import 'package:mimemo/models/enums/load_status.dart';
import 'package:mimemo/repositories/radar_repository.dart';
import 'package:mimemo/ui/screens/radar/widgets/radar_tile_provider.dart';

part 'radar_state.dart';

class RadarCubit extends Cubit<RadarState> {
  RadarCubit({required this.radarRepository, required this.mainCubit}) : super(const RadarState());
  final RadarRepository radarRepository;
  final MainCubit mainCubit;
  String? mapType;

  void init() {
    try {
      rootBundle.loadString(Assets.mapStylesDark).then((string) {
        mapType = string;
      });
      final groupColors = groupBy(
        mainCubit.state.minuteColors,
        (color) => color.type,
      );
      final tileOverlays = {
        TileOverlay(
          transparency: 0.6,
          tileOverlayId: TileOverlayId(
            state.currentMapType.name,
          ),
          tileProvider: RadarTileProvider(
            radarRepository: radarRepository,
            appMapType: state.currentMapType,
          ),
          fadeIn: false,
        ),
      };
      emit(
        state.copyWith(
          precipitationColors: groupColors,
          tileOverlays: tileOverlays,
        ),
      );
    } on Exception catch (e) {
      logger.e(e);
    }
  }

  void changeMapType(AppMapType mapType) {
    final tileOverlays = {
      TileOverlay(
        transparency: 0.2,
        tileOverlayId: TileOverlayId(
          mapType.name,
        ),
        tileProvider: RadarTileProvider(
          radarRepository: radarRepository,
          appMapType: mapType,
        ),
      ),
    };
    emit(state.copyWith(currentMapType: mapType, tileOverlays: tileOverlays));
  }
}
