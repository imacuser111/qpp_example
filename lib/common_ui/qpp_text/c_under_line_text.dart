import 'package:flutter/material.dart';
import 'package:qpp_example/extension/string/url.dart';
import 'package:qpp_example/utils/qpp_color.dart';

/// 客製化底線Text
///
///  Note:
/// - 鼠標移過去會顯示底線
/// - 若需使用連結初始化請用CUnderlineText.link
class CUnderlineText extends StatefulWidget {
  const CUnderlineText(
      {super.key, required this.text, this.fontSize = 14, required this.onTap})
      : link = '',
        isNewTab = false;

  const CUnderlineText.link(
      {super.key,
      required this.text,
      required this.link,
      this.isNewTab = false,
      this.fontSize = 14})
      : onTap = null;

  final String text;
  final String link;
  final bool isNewTab; // 是否打開新頁面
  final double fontSize;
  final Function? onTap;

  @override
  State<CUnderlineText> createState() => _CUnderlineText();
}

class _CUnderlineText extends State<CUnderlineText> {
  var isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTap != null
          ? widget.onTap!()
          : widget.link.launchURL(isNewTab: widget.isNewTab),
      onHover: (value) => setState(() {
        isHovered = value;
      }),
      child: _UnderlineText(
          text: widget.text,
          fontSize: widget.fontSize,
          isShowUnderline: isHovered),
    );
  }
}

/// 底線Text
class _UnderlineText extends StatelessWidget {
  const _UnderlineText(
      {required this.text,
      required this.fontSize,
      required this.isShowUnderline});

  final String text;
  final double fontSize;
  final bool isShowUnderline;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: QppColors.white,
        fontSize: fontSize,
        decoration: TextDecoration.underline,
        decorationThickness: 2,
        decorationColor: QppColors.white.withOpacity(isShowUnderline ? 1 : 0),
      ),
    );
  }
}
