import 'package:flutter/material.dart';

/// 背景圖片Widgth
Widget backgroundWidgth({required Widget child}) {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('desktop-bg-kv.webp'),
        fit: BoxFit.cover,
      ),
    ),
    child: child,
  );
}