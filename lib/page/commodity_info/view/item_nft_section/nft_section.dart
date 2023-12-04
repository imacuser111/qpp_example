import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qpp_example/common_ui/qpp_button/btn_arrow_up_down.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

/// NFTSection 抽象類
abstract class NFTSection<T> extends StatefulWidget {
  final T data;

  const NFTSection({Key? key, required this.data}) : super(key: key);
}

/// NFTStateSection 抽象類
abstract class StateSection extends State<NFTSection>
    with TickerProviderStateMixin {
  // 控制 Section Title 右邊的上下箭頭(指向正確的那個箭頭)
  final arrowKey = GlobalKey<StateClickArrow>();
  late bool expanded;
  late final Animation<double> _animation;
  late final Animation<double> _curve;
  late final AnimationController _scaleAnimationController;

  @override
  void initState() {
    super.initState();
    // 是否展開
    expanded = true;

    // 動畫控制器
    _scaleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    // 設定動畫
    _curve = CurvedAnimation(
        parent: _scaleAnimationController,
        curve: Curves.easeInOut,
        reverseCurve: Curves.easeInOut);
    // 動畫變化範圍
    _animation = Tween(begin: 1.0, end: 0.0).animate(_curve);
  }

  @override
  Widget build(BuildContext context) {
    // 無資料
    if (widget.data == null) {
      return const SizedBox.shrink();
    }
    // QPP Trait List 為空陣列
    if (widget.data is List) {
      if ((widget.data as List).isEmpty) {
        return const SizedBox.shrink();
      }
    }
    return Column(children: [
      NFTInfoSectionItemTitle(
        arrowKey: arrowKey,
        // section icon 圖片路徑 'assets/desktop-icon-commodity-nft-describe.svg'
        iconPath: sectionTitleIconPath,
        // section title
        title: sectionTitle,
        onTap: () {
          arrowKey.currentState?.rotate();
          setState(() {
            // forward 啟動動畫, reverse 動畫倒轉
            expanded
                ? _scaleAnimationController.forward()
                : _scaleAnimationController.reverse();
            expanded = !expanded;
          });
        },
      ),
      // size 動畫, 參考 https://github.com/YYFlutter/flutter-article/blob/master/article/animation%26motion/Flutter动画SizeTransition详解.md
      SizeTransition(
        sizeFactor: _animation,
        axis: Axis.vertical,
        //
        child: sectionContent,
      ),
    ]);
  }

  /// 上方 section icon 路徑
  String get sectionTitleIconPath;

  /// 上方 section title
  String get sectionTitle;

  /// 內容 widget
  Widget get sectionContent;
}

/// NFT Section title 元件
class NFTInfoSectionItemTitle extends StatelessWidget {
  // icon 路徑
  final String iconPath;
  // title
  final String title;

  final GlobalKey arrowKey;

  final Function()? onTap;

  const NFTInfoSectionItemTitle(
      {Key? key,
      required this.arrowKey,
      required this.iconPath,
      required this.title,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        height: 44.0,
        padding: const EdgeInsets.only(left: 60.0, right: 60.0),
        decoration: const BoxDecoration(color: QppColors.stPatricksBlue),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              width: 28.0,
              height: 28.0,
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              title,
              style: QppTextStyles.web_18pt_title_s_pastel_blue_L,
            ),
            const Expanded(child: SizedBox()),
            // 上/下箭頭
            BtnArrowUpDown(key: arrowKey, size: 20),
          ],
        ),
      ),
    );
  }
}
