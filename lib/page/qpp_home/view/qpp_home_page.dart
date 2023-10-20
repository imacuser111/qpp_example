import 'package:flutter/material.dart';
import 'package:qpp_example/extension/string/url.dart';
import 'package:qpp_example/main.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// 首頁
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [HomePageMainView()],
      ),
    );
  }
}

/// 首頁主要部分(最上層)
class HomePageMainView extends StatelessWidget {
  const HomePageMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return backgroundWidgth(
        child: Padding(
      padding: const EdgeInsets.only(top: 233, bottom: 30),
      child: Row(
        children: [
          ConstrainedBox(constraints: const BoxConstraints(minWidth: 10)),
          info()
        ],
      ),
    ));
  }

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
        Row(children: [qrcode()]),
        const SizedBox(height: 20),
        const PlayStoreButton(type: PlayStoreType.android),
        playStoreButton(PlayStoreType.iOS),
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
        Row(
          children: [
            const Icon(Icons.check_box_outlined,
                size: 32, color: Colors.amberAccent),
            const SizedBox(
              width: 10,
            ),
            RichText(
              text: const TextSpan(
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  children: <InlineSpan>[
                    TextSpan(
                        text: '即刻登入', style: TextStyle(color: Colors.white)),
                    TextSpan(
                        text: '免費擁有數位背包',
                        style: TextStyle(color: Colors.amberAccent))
                  ]),
            ),
          ],
        )
      ],
    );
  }

  /// 應用程式商店按鈕
  Widget playStoreButton(PlayStoreType type) {
    bool isAndroid = type == PlayStoreType.android;

    return Container(
      width: 170,
      height: 50,
      // 要在前面裝飾設置邊線才不會被截掉
      foregroundDecoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4))),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        child: Image.asset(isAndroid ? 'btn-google.png' : 'btn-apple.png'),
        onHover: (value) => print(value),
        onTap: () => isAndroid
            ? 'https://play.google.com/store/apps/details?id=com.qpptec.QPP'
                .launchURL()
            : 'https://apps.apple.com/tw/app/qpp/id1501319938'.launchURL(),
      ),
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

class _PlayStoreButtonState extends State<PlayStoreButton> {
  late bool isAndroid = widget.type == PlayStoreType.android;

  double positionX = 0.0;
  bool isAnimating = false;

  void startAnimation() {
    setState(() {
      isAnimating = true;
      positionX = 500.0; // 目標位置
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isAnimating = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        children: [
          Image.asset(isAndroid ? 'btn-google.png' : 'btn-apple.png'),
          Container(
            transform: Matrix4.rotationY(positionX),
            color: Colors.blue,
            width: 100,
            height: 100,
          )
        ],
      ),
      onHover: (value) => startAnimation(),
      onTap: () => isAndroid
          ? 'https://play.google.com/store/apps/details?id=com.qpptec.QPP'
              .launchURL()
          : 'https://apps.apple.com/tw/app/qpp/id1501319938'.launchURL(),
    );
  }
}

enum PlayStoreType { android, iOS }
