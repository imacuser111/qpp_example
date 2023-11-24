import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// UniversalLink QRCode(物品資訊頁、個人資訊頁...等)
class UniversalLinkQRCode extends StatelessWidget {
  const UniversalLinkQRCode(
      {super.key,
      required this.url,
      this.infoStr = 'vendor_login_scan_via_qpp'});

  final String url;

  final String infoStr;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(6))),
          child: QrImageView(
            data: url,
            size: 144,
            padding: const EdgeInsets.all(11),
          ),
        ),
        const SizedBox(height: 16),
        Text(context.tr(infoStr), style: const TextStyle(color: Colors.amber)),
      ],
    );
  }
}
