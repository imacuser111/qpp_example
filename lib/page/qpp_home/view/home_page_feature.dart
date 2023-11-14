import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qpp_example/page/qpp_home/model/qpp_home_page_model.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/screen.dart';

/// 首頁 - 特色
class HomePageFeature extends StatelessWidget {
  const HomePageFeature({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        /// 螢幕樣式
        final ScreenStyle screenStyle = constraints.screenStyle;
        final bool isDesktopStyle = screenStyle.isDesktopStyle;
        final int flex = isDesktopStyle ? 1 : 0;
        final double topAndBottomSpacing = isDesktopStyle ? 200 : 100;
        const double leftAndRightSpacing = 20;

        return Container(
          padding: EdgeInsets.only(
              top: topAndBottomSpacing,
              bottom: topAndBottomSpacing,
              left: leftAndRightSpacing,
              right: leftAndRightSpacing),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/area1-bg-xl.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Flex(
            direction: isDesktopStyle ? Axis.horizontal : Axis.vertical,
            children: [
              Expanded(flex: flex, child: _Left(screenStyle: screenStyle)),
              const SizedBox(height: 24, width: 24),
              Expanded(
                  flex: flex, child: _FeatureInfo(screenStyle: screenStyle))
            ],
          ),
        );
      },
    );
  }
}

/// 左側Widget
class _Left extends StatelessWidget {
  const _Left({required this.screenStyle});

  final ScreenStyle screenStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          '數位背包輕鬆創建物品，管理介面簡單',
          style: TextStyle(
              color: QppColor.oxfordBlue,
              fontSize: 28,
              fontWeight: FontWeight.bold),
        ),
        screenStyle.isDesktopStyle
            ? Image.asset('assets/area1-KV.png')
            : const SizedBox(),
      ],
    );
  }
}

/// 特色資訊
class _FeatureInfo extends StatelessWidget {
  const _FeatureInfo({required this.screenStyle});

  final ScreenStyle screenStyle;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
            children: HomePageFeatureInfoType.values
                .map((e) => _FeatureInfoItem(type: e, screenStyle: screenStyle))
                .toList());
      },
    );
  }
}

// 特色資訊Item
class _FeatureInfoItem extends StatefulWidget {
  const _FeatureInfoItem({required this.type, required this.screenStyle});

  final HomePageFeatureInfoType type;
  final ScreenStyle screenStyle;

  @override
  State<_FeatureInfoItem> createState() => _FeatureInfoItemState();
}

class _FeatureInfoItemState extends State<_FeatureInfoItem> {
  bool isHover = false;

  updateHover(bool value) {
    setState(() {
      isHover = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint(toString());

    final isDesktopStyle = widget.screenStyle.isDesktopStyle;
    final flex = isDesktopStyle ? 1 : 0;

    return MouseRegion(
      onEnter: (event) => updateHover(true),
      onExit: (event) => updateHover(false),
      child: Padding(
        padding: EdgeInsets.only(
            bottom: widget.type == HomePageFeatureInfoType.more ? 0 : 20),
        child: Flex(
          direction: isDesktopStyle ? Axis.horizontal : Axis.vertical,
          children: [
            SvgPicture.asset('assets/${widget.type.image}', width: 50, height: 50),
            const SizedBox(height: 20, width: 20),
            Expanded(
              flex: flex,
              child: Column(
                crossAxisAlignment: isDesktopStyle
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                children: [
                  Text(widget.type.title,
                      style: TextStyle(
                          color: isHover
                              ? QppColor.spiroDiscoBall
                              : QppColor.manatee,
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(widget.type.directions,
                      textAlign:
                          isDesktopStyle ? TextAlign.start : TextAlign.center,
                      style: TextStyle(
                          color:
                              isHover ? QppColor.oliveDrab : QppColor.manatee,
                          fontSize: 16)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
