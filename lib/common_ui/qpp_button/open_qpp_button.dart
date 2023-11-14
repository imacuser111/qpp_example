import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qpp_example/constants/server_const.dart';
import 'package:qpp_example/extension/string/url.dart';
import 'package:qpp_example/extension/throttle_debounce.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/utils/qpp_color.dart';

/// 開啟QPP數位背包按鈕
class OpenQppButton extends StatelessWidget {
  const OpenQppButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 154,
      height: 48,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: QppColor.mayaBlue),
      child: GestureDetector(
        onTap: () {
          ServerConst.appStoreUrl.launchURL();
        }.throttle(),
        child: Center(
          child: Text(
            context.tr(QppLocales.errorPageOpenQpp),
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: QppColor.stPatrickBlue),
          ),
        ),
      ),
    );
  }
}
