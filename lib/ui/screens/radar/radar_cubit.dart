import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/models/enums/load_status.dart';
import 'package:mimemo/repositories/radar_repository.dart';

part 'radar_state.dart';

class RadarCubit extends Cubit<RadarState> {
  RadarCubit({required this.radarRepository}) : super(const RadarState());
  final RadarRepository radarRepository;
}
