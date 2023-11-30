import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:qpp_example/common_ui/qpp_text/read_more_text.dart';
import 'package:qpp_example/extension/string/url.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

/// 連結及說明用, 顯示更多及開啟連結用 Text Widget
class InfoRowLinkReadMoreText extends StatelessWidget {
  final String data;
  const InfoRowLinkReadMoreText({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      data,
      textAlign: TextAlign.start,
      trimLines: 2,
      trimMode: TrimMode.Line,
      trimExpandedText: '',
      trimCollapsedText: context.tr('commodity_info_more'),
      moreStyle: QppTextStyles.web_16pt_body_category_text_L,
      style: QppTextStyles.web_16pt_body_platinum_L,
      linkTextStyle: QppTextStyles.web_16pt_body_linktext_L,
      onLinkPressed: (String url) {
        // 打開連結
        url.launchURL();
      },
    );
  }
}
