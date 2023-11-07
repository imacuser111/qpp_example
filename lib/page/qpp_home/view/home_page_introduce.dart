import 'package:flutter/material.dart';
import 'package:qpp_example/extension/string/url.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/page/qpp_home/model/qpp_home_page_model.dart';
import 'package:qpp_example/utils/screen.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// 首頁 - 產品介紹
class HomePageIntroduce extends StatelessWidget {
  const HomePageIntroduce({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;

        final leftPaddnigWidth = 300.getRealWidth();
        final rightPaddingWidth = 200.getRealWidth();
        final width =
            (availableWidth - leftPaddnigWidth - rightPaddingWidth - 50) / 2;

        print('$width, $availableWidth');

        final isSmallWidth = availableWidth < 940;

        return Padding(
          padding: const EdgeInsets.only(top: 150, bottom: 30),
          child: Column(
            children: [
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 2,
                      child: ConstrainedBox(
                          constraints: const BoxConstraints(
                              minWidth: 100, maxWidth: 300))),
                  SizedBox(width: 450, child: info()),
                  // const Spacer(),
                  const SizedBox(height: 10, width: 100),
                  Expanded(
                      flex: 3,
                      child: Image.asset('KV.png',
                          width: isSmallWidth ? 300 : 600, fit: BoxFit.cover)),
                  Expanded(
                      child: ConstrainedBox(
                          constraints: const BoxConstraints(
                              minWidth: 50, maxWidth: 200))),
                ],
              ),
              const SizedBox(height: 50),
              const Center(child: MoreAboutQPPButton())
            ],
          ),
        );
      },
    );
  }

  /// 資訊
  Widget info() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'QPP - 數位背包',
          style: TextStyle(
              color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 30),
        const Text(
          'QPP數位背包是使用門號存放各種數位商品的工具。\n手機門號即為QPP帳戶，無須註冊，想要使用數位商品時，只需下載安裝即可。\n立即打開QPP查看您有哪些數位物品吧！',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(height: 40),
        qrcode(),
        const SizedBox(height: 20),
        playStoreButtons(),
      ],
    );
  }

  Widget qrcode() {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(6))),
          child: QrImageView(
            data: 'https://qpptec.com/app/go',
            size: 110,
          ),
        ),
        const SizedBox(height: 30, width: 30),
        Expanded(
          child: Row(
            children: [
              const Icon(Icons.check_box_outlined,
                  size: 32, color: Colors.amberAccent),
              const SizedBox(width: 10),
              Expanded(
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

  /// 應用程式商店按鈕 for 首頁
  Widget playStoreButtons() {
    return const Flex(
      direction: Axis.horizontal,
      children: [
        PlayStoreButton(type: PlayStoreType.android),
        // Expanded(child: PlayStoreButton(type: PlayStoreType.android)),
        SizedBox(
          height: 10,
          width: 10,
        ),
        PlayStoreButton(type: PlayStoreType.iOS)
        // Expanded(child: PlayStoreButton(type: PlayStoreType.iOS))
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
  late bool isAndroid = widget.type == PlayStoreType.android;

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
                isAndroid ? 'btn-google.png' : 'btn-apple.png',
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
          onTap: () => isAndroid
              ? 'https://play.google.com/store/apps/details?id=com.qpptec.QPP'
                  .launchURL()
              : 'https://apps.apple.com/tw/app/qpp/id1501319938'.launchURL(),
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
          onTap: () => (),
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
