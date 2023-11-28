import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qpp_example/extension/list/list.dart';
import 'package:qpp_example/extension/string/url.dart';
import 'package:qpp_example/page/home/model/home_page_model.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/screen.dart';

/// 首頁 - 聯絡我們
class HomePageContact extends StatelessWidget {
  const HomePageContact({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/desktop_bg_area03.webp'),
            fit: BoxFit.cover,
          )),
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
          child: Column(
            children: [const _TitleContent(), _benefit(constraints.maxWidth)],
          ));
    });
  }

  Widget _benefit(double width) {
    return switch (width) {
      >= 1250 => const _DesktopStyleBenefit(),
      >= 850 && < 1250 => const _TabletStyleBenefit(),
      _ => const _MobileStyleBenefit()
    };
  }
}

/// 標題內容
class _TitleContent extends StatelessWidget {
  const _TitleContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          '將您的服務整合至QPP數位背包發揮最大效益！',
          style: TextStyle(
              color: QppColors.white, fontSize: 40, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 30),
        LayoutBuilder(builder: (context, constraints) {
          final bool isDesktopStyle = constraints.screenStyle.isDesktopStyle;
          final int flex = isDesktopStyle ? 1 : 0;

          return Flex(
              direction: isDesktopStyle ? Axis.horizontal : Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                    flex: flex,
                    child: SvgPicture.asset(
                        'assets/desktop_icon_area04_official.svg')),
                Flexible(
                  flex: flex,
                  child: Column(
                      crossAxisAlignment: isDesktopStyle
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,
                      children: const [
                        _ShadowText('立即申請合作廠商「官方帳號」',
                            textColor: QppColors.canaryYellow),
                        _LinkText(),
                      ]),
                ),
              ]);
        }),
      ],
    );
  }
}

/// 陰影文字
class _ShadowText extends StatelessWidget {
  const _ShadowText(this.text, {required this.textColor});

  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        shadows: const <Shadow>[
          Shadow(color: Colors.black, blurRadius: 20, offset: Offset.zero),
          Shadow(color: Colors.black, blurRadius: 30, offset: Offset.zero),
          Shadow(color: Colors.black, blurRadius: 40, offset: Offset.zero)
        ],
        color: textColor,
        fontSize: 40,
      ),
    );
  }
}

/// 連結文字
class _LinkText extends StatefulWidget {
  const _LinkText();

  @override
  State<_LinkText> createState() => _LinkTextState();
}

class _LinkTextState extends State<_LinkText> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return InkWell(
          onTap: () => 'mailto:info@qpptec.com'.launchURL(isNewTab: false),
          onHover: (value) => setState(() {
            isHovered = value;
          }),
          child: Container(
            padding: const EdgeInsets.only(
                bottom: 3), // space between underline and text
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: QppColors.mayaBlue
                      .withOpacity(isHovered ? 1 : 0), // Text colour here
                  width: 3, // Underline width
                ),
              ),
            ),
            child: const _ShadowText('info@qpptec.com',
                textColor: QppColors.mayaBlue),
          ),
        );
      },
    );
  }
}

/// 桌面樣式益處
class _DesktopStyleBenefit extends StatelessWidget {
  const _DesktopStyleBenefit();

  @override
  Widget build(BuildContext context) {
    const double space = 70;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: HomePageContactType.values
          .map(
            (e) => Flexible(
              child: Padding(
                  padding: EdgeInsets.only(
                      top: e.contentOfTop ? 0 : space,
                      bottom: e.contentOfTop ? space : 0),
                  child: _BenefitItem(e)),
            ),
          )
          .toList(),
    );
  }
}

/// 手機樣式益處
class _TabletStyleBenefit extends StatelessWidget {
  const _TabletStyleBenefit();

  @override
  Widget build(BuildContext context) {
    const types = HomePageContactType.values;

    return Column(children: [
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: types.filterLast
              .map((e) => Flexible(child: _BenefitItem(e)))
              .toList()),
      _BenefitItem(types.last)
    ]);
  }
}

/// 手機樣式益處
class _MobileStyleBenefit extends StatelessWidget {
  const _MobileStyleBenefit();

  @override
  Widget build(BuildContext context) {
    const types = HomePageContactType.values;

    return Column(
        children: types
            .map((e) => Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: _BenefitItem(e),
                ))
            .toList());
  }
}

/// 益處Item
class _BenefitItem extends StatelessWidget {
  const _BenefitItem(this.type);

  final HomePageContactType type;

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      SvgPicture.asset('assets/desktop_bg_area03_box.svg'),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(type.title,
            style: const TextStyle(color: QppColors.canaryYellow, fontSize: 24)),
        const SizedBox(height: 17),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 280),
          child: Text(type.directions,
              style: const TextStyle(color: QppColors.white, fontSize: 18)),
        ),
      ]),
    ]);
  }
}
