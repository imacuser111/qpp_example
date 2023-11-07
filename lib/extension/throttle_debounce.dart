import 'dart:async';
import 'package:flutter/material.dart';

enum ClickType { none, throttle, throttleWithTimeout, debounce }

extension FunctionExt on Function {
  VoidCallback throttle() {
    return FunctionProxy(this).throttle;
  }

  VoidCallback throttleWithTimeout({int? timeout}) {
    return FunctionProxy(this, timeout: timeout).throttleWithTimeout;
  }

  VoidCallback debounce({int? timeout}) {
    return FunctionProxy(this, timeout: timeout).debounce;
  }
}

class FunctionProxy {
  bool? _funcThrottle;
  Timer? _funcDebounce;
  final Function? target;

  final int timeout;

  FunctionProxy(this.target, {int? timeout}) : timeout = timeout ?? 500;

  void throttle() async {
    bool enable = _funcThrottle ?? true;
    if (enable) {
      _funcThrottle = false;
      try {
        await target?.call();
      } catch (e) {
        rethrow;
      } finally {
        _funcThrottle = null;
      }
    }
  }

  void throttleWithTimeout() {
    bool enable = _funcThrottle ?? true;

    if (enable) {
      _funcThrottle = false;
      Timer(Duration(milliseconds: timeout), () {
        _funcThrottle = null;
      });
      target?.call();
    }
  }

  void debounce() {
    Timer? timer = _funcDebounce;
    timer?.cancel();
    timer = Timer(Duration(milliseconds: timeout), () {
      Timer? t = _funcDebounce;
      t?.cancel();
      target?.call();
    });
    _funcDebounce = timer;
  }
}
