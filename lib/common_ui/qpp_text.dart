import 'package:flutter/material.dart';
import 'package:qpp_example/extension/string/url.dart';
import 'package:qpp_example/utils/qpp_color.dart';

/// 客製化連結Text
///
/// Note: 鼠標移過去會顯示底線
class CLinkText extends StatefulWidget {
  const CLinkText(
      {super.key,
      required this.text,
      required this.link,
      this.isNewTab = false,
      this.fontSize = 14});

  final String text;
  final String link;
  final bool isNewTab; // 是否打開新頁面
  final double fontSize;

  @override
  State<CLinkText> createState() => _CLinkTextState();
}

class _CLinkTextState extends State<CLinkText> {
  var isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.link.launchURL(isNewTab: widget.isNewTab),
      onHover: (value) => setState(() {
        isHovered = value;
      }),
      child: _underlineText(
          text: widget.text,
          fontSize: widget.fontSize,
          isShowUnderline: isHovered),
    );
  }
}

/// 客製化底線Text
///
/// Note: 鼠標移過去會顯示底線
class CUnderlineText extends StatefulWidget {
  const CUnderlineText(
      {super.key, required this.text, this.fontSize = 14, required this.onTap});

  final String text;
  final double fontSize;
  final Function onTap;

  @override
  State<CUnderlineText> createState() => _CUnderlineText();
}

class _CUnderlineText extends State<CUnderlineText> {
  var isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTap(),
      onHover: (value) => setState(() {
        isHovered = value;
      }),
      child: _underlineText(
          text: widget.text,
          fontSize: widget.fontSize,
          isShowUnderline: isHovered),
    );
  }
}

/// 底線Text
Text _underlineText(
    {required String text,
    required double fontSize,
    required bool isShowUnderline}) {
  return Text(
    text,
    style: TextStyle(
      color: QppColor.white,
      fontSize: fontSize,
      decoration: TextDecoration.underline,
      decorationThickness: 2,
      decorationColor: QppColor.white.withOpacity(isShowUnderline ? 1 : 0),
    ),
  );
}
