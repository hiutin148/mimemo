import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/common/utils/logger.dart';

class BaseCubit<T> extends Cubit<T> {
  BaseCubit(super.initialState);

  @override
  void emit(T state) {
    if (isClosed) return;
    super.emit(state);
  }

  @protected
  Future<void> guard(
      Future<void> Function() action, {
        void Function(Object error)? onError,
      }) async {
    try {
      await action();
    } on Exception catch (e) {
      logger.e(e);
      onError?.call(e);
    }
  }
}
