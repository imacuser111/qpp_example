import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:sprintf/sprintf.dart';

/// 計時器Text
class CTimerText extends StatefulWidget {
  const CTimerText(this.text, {super.key, this.style, required this.interval});

  final String text;
  final TextStyle? style;

  /// 倒數時間(單位：秒)
  final int interval;

  @override
  State<CTimerText> createState() => _CTimerTextState();
}

class _CTimerTextState extends State<CTimerText> {
  /// 剩餘秒數
  late int remainingSeconds;

  late Timer timer;

  @override
  void initState() {
    super.initState();

    remainingSeconds = widget.interval;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          remainingSeconds -= 1;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    remainingSeconds == 0 ? context.pop() : null;
    return Text(sprintf(widget.text, [remainingSeconds]), style: widget.style);
  }
}
