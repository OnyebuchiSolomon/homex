import 'dart:async';
import 'package:flutter/foundation.dart';

class CountdownViewModel extends ChangeNotifier {
  int _secondsRemaining;
  int _initialSeconds;
  Timer? _timer;

  CountdownViewModel({int initialSeconds = 60})
      : _secondsRemaining = initialSeconds,
        _initialSeconds = initialSeconds;

  int get secondsRemaining => _secondsRemaining;
  bool get isRunning => _timer != null && _timer!.isActive;
  bool get isFinished => _secondsRemaining <= 0;

  void startCountdown() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining <= 0) {
        timer.cancel();
        notifyListeners();
      } else {
        _secondsRemaining--;
        notifyListeners();
      }
    });
  }

  void setTime(int seconds) {
    _secondsRemaining = seconds;
    _initialSeconds = seconds;
    notifyListeners();
  }

  void reset() {
    _secondsRemaining = _initialSeconds;
    _timer?.cancel();
    notifyListeners();
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
