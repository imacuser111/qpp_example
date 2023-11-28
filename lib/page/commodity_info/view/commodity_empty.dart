import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/utils/qpp_color.dart';

/// 無此物品
class EmptyInfo extends StatelessWidget {
  final bool isDesktop;
  const EmptyInfo.desktop({super.key}) : isDesktop = true;
  const EmptyInfo.mobile({super.key}) : isDesktop = false;

  @override
  Widget build(BuildContext context) {
    return isDesktop
        ? Container(
            constraints: const BoxConstraints(maxWidth: 1280, maxHeight: 324),
            width: double.infinity,
            height: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _emptyImg(),
                Padding(
                  padding: const EdgeInsets.only(left: 36),
                  child: Text(
                    context.tr(QppLocales.qppState9),
                    style: const TextStyle(
                        fontSize: 16, color: QppColors.babyBlueEyes),
                  ),
                )
              ],
            ),
          )
        : Container(
            constraints: const BoxConstraints(maxWidth: 500, maxHeight: 500),
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _emptyImg(),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    context.tr(QppLocales.qppState9),
                    style: const TextStyle(
                        fontSize: 16, color: QppColors.babyBlueEyes),
                  ),
                )
              ],
            ),
          );
  }

  _emptyImg() {
    return SvgPicture.asset(
      'assets/pic-empty-default.svg',
      width: isDesktop ? 202 : 165,
      height: isDesktop ? 146 : 119,
    );
  }
}
