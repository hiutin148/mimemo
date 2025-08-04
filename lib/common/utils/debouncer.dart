import 'dart:async';
import 'dart:ui';

class Debouncer {

  Debouncer({this.milliseconds = kDefaultDebounceDelay});
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;
  static const kDefaultDebounceDelay = 500;

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void dispose() {
    _timer?.cancel();
  }
}
