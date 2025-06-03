import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/models/entities/one_minute_cast/one_minute_cast.dart';
import 'package:mimemo/models/enums/load_status.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  Future<void> init() async {}
}
