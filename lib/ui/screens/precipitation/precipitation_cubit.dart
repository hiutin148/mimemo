import 'package:mimemo/core/base/base_cubit.dart';
import 'package:mimemo/models/enums/load_status.dart';

part 'precipitation_state.dart';

class PrecipitationCubit extends BaseCubit<PrecipitationState> {
  PrecipitationCubit() : super(PrecipitationState());
}
