import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// UniversalLink QRCode(物品資訊頁、個人資訊頁...等)
class UniversalLinkQRCode extends StatelessWidget {
  const UniversalLinkQRCode({super.key, required this.url, this.size = 144});

  final String url;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(6))),
            child: QPPQRCode(data: url, size: size)),
        const SizedBox(height: 16),
        Text(context.tr('vendor_login_scan_via_qpp'),
            style: QppTextStyles.web_16pt_body_canary_yellow_C),
      ],
    );
  }
}

class QPPQRCode extends StatelessWidget {
  const QPPQRCode({super.key, required this.data, required this.size});

  final String data;
  final double size;

  @override
  Widget build(BuildContext context) {
    return QrImageView(
      data: data,
      embeddedImage: const Svg('assets/pic-qrcode.svg'),
      size: size,
      padding: const EdgeInsets.all(11),
    );
  }
}
