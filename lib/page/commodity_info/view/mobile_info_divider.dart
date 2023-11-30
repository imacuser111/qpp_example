import 'package:flutter/material.dart';
import 'package:qpp_example/utils/qpp_color.dart';

class MobileInfoDivider extends StatelessWidget {
  final bool isMobile;
  const MobileInfoDivider({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return isMobile
        ? Container(
            height: 3,
            color: QppColors.black,
          )
        : const SizedBox.shrink();
  }
}
