import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qpp_example/extension/string/url.dart';
import 'package:qpp_example/page/qpp_home/model/qpp_home_page_model.dart';
import 'package:qpp_example/utils/qpp_color.dart';

/// 首頁 - 聯絡我們
class HomePageContact extends StatelessWidget {
  const HomePageContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('desktop_bg_area03.webp'),
        fit: BoxFit.cover,
      )),
      padding:
          const EdgeInsets.only(top: 100, bottom: 100, left: 20, right: 20),
      child: Column(children: [_TitleContent(), _Benefit()]),
    );
  }
}

/// 標題內容
class _TitleContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          '將您的服務整合至QPP數位背包發揮最大效益！',
          style: TextStyle(
              color: QppColor.white, fontSize: 40, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 30),
        Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  child: SvgPicture.asset('desktop_icon_area04_official.svg')),
              Flexible(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _shadowText('立即申請合作廠商「官方帳號」',
                          textColor: QppColor.laserLemon),
                      _linkText(),
                    ]),
              ),
            ]),
      ],
    );
  }

  Widget _shadowText(String text, {required Color textColor}) {
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

  StatefulWidget _linkText() {
    bool isHovered = false;

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
                  color: QppColor.mayaBlue
                      .withOpacity(isHovered ? 1 : 0), // Text colour here
                  width: 3, // Underline width
                ),
              ),
            ),
            child: _shadowText('info@qpptec.com', textColor: QppColor.mayaBlue),
          ),
        );
      },
    );
  }
}

/// 益處
class _Benefit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: HomePageContactType.values
          .map((e) => Flexible(child: _benefitItem(e)))
          .toList(),
    );
  }

  Widget _benefitItem(HomePageContactType type) {
    const double space = 70;

    return Padding(
      padding: EdgeInsets.only(
          top: type.contentOfTop ? 0 : space,
          bottom: type.contentOfTop ? space : 0),
      child: Stack(alignment: Alignment.center, children: [
        SvgPicture.asset('desktop_bg_area03_box.svg'),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(type.title,
              style: const TextStyle(color: QppColor.laserLemon, fontSize: 24)),
          const SizedBox(height: 17),
          SizedBox(
            width: 280,
            child: Text(type.directions,
                style: const TextStyle(color: QppColor.white, fontSize: 18)),
          ),
        ]),
      ]),
    );
  }
}
