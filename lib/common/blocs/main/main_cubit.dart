import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/models/entities/position_info/position_info.dart';
import 'package:mimemo/repositories/position_repository.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  final PositionRepository positionRepository;

  MainCubit({required this.positionRepository}) : super(MainState());

  Future<void> init() async {
    // final position =
  }
}
