import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qpp_example/constants/server_const.dart';
import 'package:qpp_example/extension/string/url.dart';
import 'package:qpp_example/page/qpp_home/model/qpp_home_page_model.dart';
import 'package:qpp_example/page/qpp_home/view/qpp_home_page.dart';
import 'package:qpp_example/utils/screen.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// 首頁 - 產品介紹
class HomePageIntroduce extends StatelessWidget {
  const HomePageIntroduce({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 200, bottom: 80),
      child: Column(
        children: [
          LayoutBuilder(
              builder: (context, constraints) =>
                  constraints.screenStyle.isDesktopStyle
                      ? const _Horizontal()
                      : const _Vertical()),
          const SizedBox(height: 50),
          const Center(child: MoreAboutQPPButton())
        ],
      ),
    );
  }
}

/// 橫板
class _Horizontal extends StatelessWidget {
  const _Horizontal();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Spacer(flex: 2),
        const _Info(isHorizontal: true),
        const SizedBox(width: 100),
        Expanded(flex: 3, child: Image.asset('KV.png', fit: BoxFit.cover)),
        const Spacer(),
      ],
    );
  }
}

/// 直板
class _Vertical extends StatelessWidget {
  const _Vertical();

  @override
  Widget build(BuildContext context) {
    return const _Info(isHorizontal: false);
  }
}

/// 資訊
class _Info extends StatelessWidget {
  const _Info({required this.isHorizontal});

  final bool isHorizontal;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 450,
      child: Column(
        crossAxisAlignment:
            isHorizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          const Text(
            'QPP - 數位背包',
            style: TextStyle(
                color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          Text(
            context.tr('home_section_1_p'),
            textAlign: isHorizontal ? TextAlign.start : TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          isHorizontal
              ? const SizedBox()
              : Image.asset('KV.png', fit: BoxFit.cover),
          const SizedBox(height: 40),
          _Qrcode(isHorizontal: isHorizontal),
          const SizedBox(height: 20),
          _PlayStoreButtons(isHorizontal: isHorizontal),
        ],
      ),
    );
  }
}

/// QRCode
class _Qrcode extends StatelessWidget {
  const _Qrcode({required this.isHorizontal});

  final bool isHorizontal;

  @override
  Widget build(BuildContext context) {
    final int flex = isHorizontal ? 1 : 0;

    return Flex(
      direction: isHorizontal ? Axis.horizontal : Axis.vertical,
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(6))),
          child: MouseRegion(
            cursor: SystemMouseCursors.click, // 改鼠標樣式
            child: GestureDetector(
              onTap: () => ServerConst.appStoreUrl.launchURL(),
              child: QrImageView(
                data: ServerConst.appStoreUrl,
                size: 110,
              ),
            ),
          ),
        ),
        isHorizontal ? const SizedBox(width: 30) : const SizedBox(height: 30),
        Expanded(
          flex: flex,
          child: Row(
            mainAxisAlignment: isHorizontal
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_box_outlined,
                  size: 32, color: Colors.amberAccent),
              const SizedBox(width: 10),
              Expanded(
                flex: flex,
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    children: <InlineSpan>[
                      TextSpan(
                          text: '即刻登入', style: TextStyle(color: Colors.white)),
                      TextSpan(
                          text: '免費擁有數位背包',
                          style: TextStyle(color: Colors.amberAccent))
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

/// 應用程式商店按鈕 for 首頁
class _PlayStoreButtons extends StatelessWidget {
  const _PlayStoreButtons({required this.isHorizontal});

  final bool isHorizontal;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isHorizontal ? MainAxisAlignment.start : MainAxisAlignment.center,
      children: const [
        PlayStoreButton(type: PlayStoreType.google),
        SizedBox(width: 10),
        PlayStoreButton(type: PlayStoreType.apple)
      ],
    );
  }
}

/// 應用程式商店按鈕
class PlayStoreButton extends StatefulWidget {
  const PlayStoreButton({super.key, required this.type});

  final PlayStoreType type;

  @override
  State<PlayStoreButton> createState() => _PlayStoreButtonState();
}

class _PlayStoreButtonState extends State<PlayStoreButton>
    with TickerProviderStateMixin {
  bool isHover = false;

  void expandAnimation() {
    setState(() {
      isHover = true;
    });
  }

  void collapseAnimation() {
    setState(() {
      isHover = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: isHover ? 1.05 : 1.0,
      child: Container(
        // 要在前面裝飾設置邊線才不會被截掉
        foregroundDecoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          child: Stack(
            children: [
              Image.asset(
                widget.type.image,
                fit: BoxFit.cover,
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                left: isHover ? 175 : -125,
                child: Container(
                  transform: Matrix4.rotationZ(-0.8),
                  width: 50,
                  height: 200,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
            ],
          ),
          onHover: (isHover) =>
              isHover ? expandAnimation() : collapseAnimation(),
          onTap: () => widget.type.url.launchURL(),
        ),
      ),
    );
  }
}

/// 更多關於QPP Button
class MoreAboutQPPButton extends StatefulWidget {
  const MoreAboutQPPButton({super.key});

  @override
  State<MoreAboutQPPButton> createState() => _MoreAboutQPPButtonState();
}

class _MoreAboutQPPButtonState extends State<MoreAboutQPPButton>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            final currentContext = featureKey.currentContext;
            if (currentContext != null) {
              Scrollable.ensureVisible(currentContext,
                  duration: const Duration(seconds: 1));
            }
          },
          child: Column(
            children: [
              const Text(
                'More About QPP',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 10),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.translate(
                      offset: Offset(0, _controller.value * 15),
                      child: const Icon(Icons.keyboard_double_arrow_down,
                          size: 15, color: Colors.grey));
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}

class CLayoutBuilder extends StatelessWidget {
  const CLayoutBuilder(
      {super.key, required this.desktopWidget, required this.mobile});

  final Widget desktopWidget;
  final Widget mobile;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        /// 螢幕樣式
        final ScreenStyle screenStyle = constraints.screenStyle;

        return switch (screenStyle) {
          ScreenStyle.desktop => desktopWidget,
          _ => mobile,
        };
      },
    );
  }
}
