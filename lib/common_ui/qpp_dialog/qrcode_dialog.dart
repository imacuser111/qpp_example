import 'package:flutter/material.dart';
import 'package:qpp_example/common_ui/qpp_dialog/c_dialog.dart';
import 'package:qpp_example/common_ui/qpp_qrcode/universal_link_qrcode.dart';
import 'package:qpp_example/common_ui/qpp_text/c_timer_text.dart';
import 'package:qpp_example/utils/qpp_color.dart';

/// QRCode對話框
class QRCodeDialog extends StatelessWidget {
  const QRCodeDialog({
    super.key,
    required this.text,
    required this.subText,
    required this.url,
    this.timerText = "",
  });

  final String text;
  final String subText;
  final String timerText;
  final String url;

  @override
  Widget build(BuildContext context) {
    return CDialog(
        height: 468,
        width: 560,
        text: text,
        subText: subText,
        child: Column(
          children: [
            UniversalLinkQRCode(url: url, size: 168),
            const SizedBox(height: 36),
            CTimerText(
              timerText,
              style: const TextStyle(fontSize: 20, color: QppColors.white),
              interval: 600,
            )
          ],
        ));
  }
}
