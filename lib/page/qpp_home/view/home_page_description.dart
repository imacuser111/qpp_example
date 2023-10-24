import 'package:flutter/material.dart';


/// 首頁 - 使用說明
class HomePageDescription extends StatelessWidget {
  const HomePageDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [left()]);
  }

  Widget left() {
    return Container(
      padding: const EdgeInsets.only(top: 100, bottom: 100),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('area1-bg-xl.jpg'),
          fit: BoxFit.cover,
        ),
      )
    );
  }

}