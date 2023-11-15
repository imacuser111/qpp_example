import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// UniversalLink QRCode(物品資訊頁、個人資訊頁...等)
class UniversalLinkQRCode extends StatelessWidget {
  const UniversalLinkQRCode(
      {super.key, required this.str, this.infoStr = '掃描條碼開啟QPP'});

  final String str;

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
            data: str,
            size: 144,
            padding: const EdgeInsets.all(11),
          ),
        ),
        const SizedBox(height: 16),
        Text(infoStr, style: const TextStyle(color: Colors.amber)),
      ],
    );
  }
}
