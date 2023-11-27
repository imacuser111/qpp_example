import 'package:flutter/material.dart';
import 'package:qpp_example/common_ui/qpp_button/open_qpp_button.dart';
import 'package:qpp_example/common_ui/qpp_dialog/c_dialog.dart';
import 'package:qpp_example/common_ui/qpp_text/c_timer_text.dart';
import 'package:qpp_example/utils/qpp_color.dart';

/// 開啟QPP對話框
class OpenQppDialog extends StatelessWidget {
  const OpenQppDialog({
    super.key,
    required this.text,
    required this.subText,
    this.timerText = "",
  });

  final String text;
  final String subText;
  final String timerText;

  @override
  Widget build(BuildContext context) {
    return CDialog(
      height: 269,
      width: 327,
      text: text,
      subText: subText,
      child: Column(
        children: [
          const OpenQppButton(),
          const SizedBox(height: 36),
          CTimerText(
            timerText,
            style: const TextStyle(fontSize: 14, color: QppColor.pastelBlue),
            interval: 600,
          )
        ],
      ),
    );
  }
}
