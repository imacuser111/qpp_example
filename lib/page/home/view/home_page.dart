import 'package:flutter/material.dart';
import 'package:qpp_example/page/home/view/home_page_contact.dart';
import 'package:qpp_example/page/home/view/home_page_description.dart';
import 'package:qpp_example/page/home/view/home_page_feature.dart';
import 'package:qpp_example/page/home/view/home_page_footer.dart';
import 'package:qpp_example/page/home/view/home_page_introduce.dart';

// 要滾動到位置的全局鍵
final GlobalKey introduceKey = GlobalKey();
final GlobalKey featureKey = GlobalKey();
final GlobalKey descriptionKey = GlobalKey();
final GlobalKey contactKey = GlobalKey();

/// 首頁
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          HomePageIntroduce(key: introduceKey),
          HomePageFeature(key: featureKey),
          HomePageDescription(key: descriptionKey),
          HomePageContact(key: contactKey),
          const HomePageFooter(),
        ],
      ),
    );
  }
}
