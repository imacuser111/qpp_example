import 'package:flutter/material.dart';
import 'package:qpp_example/page/qpp_home/model/qpp_home_page_model.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/screen.dart';

/// 首頁 - 使用說明
class HomePageDescription extends StatelessWidget {
  const HomePageDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final ScreenStyle screenStyle = constraints.screenStyle;
      final flex = screenStyle.isDesktopStyle ? 1 : 0;

      // return switch (screenStyle) {
      //   ScreenStyle.desktop => const Row(children: [Expanded(child: _PhoneDescription()),
      //       Expanded(child: _DirectoryAndForumDescription())]),
      //   _ => const Column(children: [_PhoneDescription(),
      //       _DirectoryAndForumDescription()]),
      // };

      return Flex(
          direction:
              screenStyle.isDesktopStyle ? Axis.horizontal : Axis.vertical,
          children: [
            Expanded(
                flex: flex, child: _PhoneDescription(screenStyle: screenStyle)),
            Expanded(
                flex: flex,
                child: _DirectoryAndForumDescription(screenStyle: screenStyle))
          ]);
    });
  }
}

/// 手機說明
class _PhoneDescription extends StatefulWidget {
  const _PhoneDescription({required this.screenStyle});

  final ScreenStyle screenStyle;

  @override
  State<_PhoneDescription> createState() => _PhoneDescriptionState();
}

class _PhoneDescriptionState extends State<_PhoneDescription> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // 获取屏幕信息
    final height = MediaQuery.of(context).size.height;
    final isDesktopStyle = widget.screenStyle.isDesktopStyle;
    const type = HomePageDescriptionType.phone;

    return MouseRegion(
      onEnter: (event) => setState(() {
        _isHovered = true;
      }),
      onExit: (event) => setState(() {
        _isHovered = false;
      }),
      child: SizedBox(
        height: isDesktopStyle ? height : height * 3 / 4,
        child: Stack(children: [
          _BgWidget(type, isHovered: _isHovered),
          Column(children: [
            Expanded(
              flex: isDesktopStyle ? 1 : 2,
              child: Container(
                color: QppColor.onyx60,
                padding: const EdgeInsets.only(left: 50, right: 50),
                alignment: Alignment.center,
                child: Flex(
                  direction: isDesktopStyle ? Axis.horizontal : Axis.vertical,
                  mainAxisAlignment: isDesktopStyle
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/desktop-pic-qpp-logo-01.png'),
                    const SizedBox(height: 50, width: 20),
                    Expanded(
                      flex: isDesktopStyle ? 1 : 0,
                      child: const Text(
                        '數位背包功用多，打造便利生活圈！',
                        style: TextStyle(
                            color: QppColor.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: _Content(type: type, screenStyle: widget.screenStyle)),
          ]),
        ]),
      ),
    );
  }
}

/// 通訊錄與討論區說明
class _DirectoryAndForumDescription extends StatelessWidget {
  const _DirectoryAndForumDescription({required this.screenStyle});

  final ScreenStyle screenStyle;

  @override
  Widget build(BuildContext context) {
    // 获取屏幕信息
    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenStyle.isDesktopStyle ? height : (height * 3 / 4) * 2,
      child: Column(children: [
        Expanded(
            child: _Content(
                type: HomePageDescriptionType.directory,
                screenStyle: screenStyle)),
        Expanded(
            child: _Content(
                type: HomePageDescriptionType.forum, screenStyle: screenStyle)),
      ]),
    );
  }
}

/// 內容
class _Content extends StatefulWidget {
  const _Content({required this.type, required this.screenStyle});

  final HomePageDescriptionType type;
  final ScreenStyle screenStyle;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        onEnter: (event) => setState(() {
              _isHovered = true;
            }),
        onExit: (event) => setState(() {
              _isHovered = false;
            }),
        child: widget.screenStyle.isDesktopStyle
            ? _DesktopStyleContent(widget.type, isHovered: _isHovered)
            : _PhoneStyleContent(widget.type, isHovered: _isHovered));
  }
}

/// 桌面樣式內容
class _DesktopStyleContent extends StatelessWidget {
  const _DesktopStyleContent(this.type, {required this.isHovered});

  final HomePageDescriptionType type;
  final bool isHovered;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      type.conetntOfRight ? _Bg(type, screenStyle: ScreenStyle.desktop, isHovered: isHovered) : const SizedBox(),
      Expanded(
        child: Container(
          color: QppColor.yaleBlue,
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(type.title,
                  style: const TextStyle(
                      color: QppColor.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(type.directions,
                  style: const TextStyle(color: QppColor.white, fontSize: 18))
            ],
          ),
        ),
      ),
      type.conetntOfRight ? const SizedBox() : _Bg(type, screenStyle: ScreenStyle.desktop, isHovered: isHovered),
    ]);
  }
}

/// 手機樣式內容
class _PhoneStyleContent extends StatelessWidget {
  const _PhoneStyleContent(this.type, {required this.isHovered});

  final HomePageDescriptionType type;
  final bool isHovered;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _Bg(type, screenStyle: ScreenStyle.mobile, isHovered: isHovered, flex: 2),
      Expanded(
        child: Container(
          color: QppColor.yaleBlue,
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(type.title,
                  style: const TextStyle(
                      color: QppColor.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(type.directions,
                  style: const TextStyle(color: QppColor.white, fontSize: 18),
                  textAlign: TextAlign.center)
            ],
          ),
        ),
      ),
    ]);
  }
}

class _Bg extends StatelessWidget {
  const _Bg(this.type, {required this.screenStyle, required this.isHovered, this.flex = 1});

  final HomePageDescriptionType type;
  final ScreenStyle screenStyle;
  final bool isHovered;
  final int flex;

  @override
  Widget build(BuildContext context) {
    final bool isShowBackground = type != HomePageDescriptionType.phone;

    return Expanded(
      flex: (screenStyle.isDesktopStyle || isShowBackground) ? flex : 0,
      child: _BgWidget(type,
          isHovered: isHovered, isShowBackground: isShowBackground),
    );
  }
}

class _BgWidget extends StatelessWidget {
  const _BgWidget(this.type,
      {required this.isHovered, this.isShowBackground = true});

  final HomePageDescriptionType type;
  final bool isHovered;
  final bool isShowBackground;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: isShowBackground ? null : 0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      transform: Matrix4.identity()..scale(isHovered ? 1.1 : 1.0),
      child: Container(
        decoration: BoxDecoration(
          image: isShowBackground
              ? DecorationImage(
                  image: AssetImage(type.image),
                  fit: BoxFit.cover,
                )
              : null,
        ),
      ),
    );
  }
}
