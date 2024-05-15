import 'dart:async';
import 'package:flutter/material.dart';

class Debounce {
  final Duration delay;
  Timer? _timer;
  Debounce({required this.delay});

  ///The [callback] function is invoked after the given duration.
  void call(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(delay, action);
  }
}
