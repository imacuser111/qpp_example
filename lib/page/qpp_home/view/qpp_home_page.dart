import 'package:flutter/material.dart';
import 'package:qpp_example/page/qpp_home/view/home_page_feature.dart';
import 'package:qpp_example/page/qpp_home/view/home_page_introduce.dart';

/// 首頁
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [HomePageIntroduce(), HomePageFeature()],
      ),
    );
  }
}