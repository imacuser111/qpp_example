import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/api/core/api_response.dart';
import 'package:qpp_example/api/podo/core/base_response.dart';
import 'package:qpp_example/qpp_info_body/view_model/qpp_info_body_view_model.dart';
import 'package:qr_flutter/qr_flutter.dart';

class InformationOuterFrame extends StatelessWidget {
  InformationOuterFrame({super.key, required this.userID});

  final int userID;

  late final StateNotifierProvider<UserSelectInfoNotifier,
          ApiResponse<BaseResponse>?> userSelectInfoStateProvider =
      StateNotifierProvider((ref) {
    Future.microtask(() => ref.notifier.getUserInfo(userID));
    return UserSelectInfoNotifier(ApiResponse.initial());
  });

  @override
  Widget build(BuildContext context) {
    debugPrint('InformationOuterFrame build');

    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1280),
              child: Padding(
                padding: const EdgeInsets.only(top: 180, bottom: 48, left: 20, right: 20),
                child: Container(
                  clipBehavior: Clip.hardEdge, // 超出的部分，裁剪掉
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Column(
                    children: [
                      AvatarWidget(
                        userSelectInfoStateProvider:
                            userSelectInfoStateProvider,
                        userID: userID,
                      ),
                      InformationDescriptionWidget(
                        userSelectInfoStateProvider:
                            userSelectInfoStateProvider,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 89),
              child: const QRCodeWidget(
                str:
                    "https://qpptec.com/app/information?phoneNumber=886972609811&lang=zh_TW",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 頭像Widget
class AvatarWidget extends StatelessWidget {
  const AvatarWidget(
      {super.key,
      required this.userSelectInfoStateProvider,
      required this.userID});

  final int userID;

  final StateNotifierProvider<UserSelectInfoNotifier,
      ApiResponse<BaseResponse>?> userSelectInfoStateProvider;

  @override
  Widget build(BuildContext context) {
    debugPrint('AvatarWidget build');

    return Container(
      height: 265,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('desktop_pic_commodity_largepic_default.webp'),
        ),
      ),
      child: Stack(
        children: [
          ModalBarrier(color: Colors.black.withOpacity(0.7)), // 遮罩
          Center(
            child: Column(
              children: [
                const SizedBox(height: 36),
                const SizedBox(
                  width: 100,
                  height: 100,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent, // 設置透明背景
                    backgroundImage:
                        AssetImage('desktop_pic_profile_avatar_default.png'),
                  ),
                ),
                const SizedBox(height: 20),
                Consumer(
                  builder: (context, ref, child) {
                    final notifier = ref.watch(userSelectInfoStateProvider);
                    final response = (notifier?.data);
                    return Text(
                      response?.userSelectInfoResponse.name ?? '',
                      style: const TextStyle(
                        color: Colors.amber,
                        fontSize: 28,
                        fontWeight: FontWeight.w400,
                      ),
                    );
                  },
                ),
                Text(
                  userID.toString(),
                  style: const TextStyle(
                    color: Colors.amber,
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 資訊說明Widget
class InformationDescriptionWidget extends ConsumerWidget {
  const InformationDescriptionWidget(
      {super.key, required this.userSelectInfoStateProvider});

  final StateNotifierProvider<UserSelectInfoNotifier,
      ApiResponse<BaseResponse>?> userSelectInfoStateProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('InformationDescriptionWidget build');

    final notifier = ref.watch(userSelectInfoStateProvider);
    final response = (notifier?.data);

    final String text = response?.userSelectInfoResponse.info ?? '';
    const TextStyle textStyle = TextStyle(fontSize: 18, color: Colors.white);
    final double textH = text.height(textStyle, context);

    return Container(
      height: textH + 40 * 2,
      color: const Color.fromRGBO(22, 32, 68, 1),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 61, right: 60),
          child: Text(text, style: textStyle),
        ),
      ),
    );
  }
}

// QRCode
class QRCodeWidget extends StatelessWidget {
  const QRCodeWidget({super.key, required this.str});

  final String str;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(6))),
          child: QrImageView(
            data: str,
            size: 144,
            padding: const EdgeInsets.all(11),
          ),
        ),
        const SizedBox(height: 16),
        const Text('掃描條碼開啟QPP', style: TextStyle(color: Colors.amber)),
      ],
    );
  }
}

// MARK: - 字串擴充
extension StringExtension on String {
  /// 計算文字Size(\n不會計算)
  Size size(TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: this, style: style),
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  /// 計算文字高度
  double height(TextStyle style, BuildContext context) {
    // final mediaQuery = MediaQuery.of(context);
    FlutterView window = PlatformDispatcher.instance.views.first;

    final Size sizeFull = (TextPainter(
      text: TextSpan(
        text: replaceAll('\n', ''),
        style: style,
      ),
      // textScaleFactor: mediaQuery.textScaleFactor,
      textDirection: TextDirection.ltr,
    )..layout())
        .size;

    final numberOfLinebreaks = split('\n').length;

    final numberOfLines =
        (sizeFull.width / (window.physicalSize.width)).ceil() +
            numberOfLinebreaks;

    return sizeFull.height * numberOfLines;
  }
}
