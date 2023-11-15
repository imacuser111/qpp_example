import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/common_ui/qpp_button/open_qpp_button.dart';
import 'package:qpp_example/common_ui/qpp_qrcode/universal_link_qrcode.dart';
import 'package:qpp_example/common_ui/qpp_text/read_more_text.dart';
import 'package:qpp_example/constants/server_const.dart';
import 'package:qpp_example/extension/build_context.dart';
import 'package:qpp_example/extension/string/url.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/page/user_information/view_model/user_information_view_model.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_contanst.dart';
import 'package:qpp_example/utils/qpp_image_utils.dart';
import 'package:qpp_example/utils/screen.dart';

/// 用戶資訊頁
class UserInformationOuterFrame extends StatefulWidget {
  const UserInformationOuterFrame(
      {super.key, required this.userID, required this.uri});

  final String userID;
  final String uri;

  @override
  State<UserInformationOuterFrame> createState() =>
      _UserInformationOuterFrameState();
}

class _UserInformationOuterFrameState extends State<UserInformationOuterFrame> {
  @override
  void initState() {
    super.initState();

    userInformationProvider =
        ChangeNotifierProvider<UserInformationChangeNotifier>((ref) {
      int? userID = int.tryParse(widget.userID);

      if (userID != null) {
        Future.microtask(() => ref.notifier.setUserID(userID));
        Future.microtask(() => ref.notifier.getUserInfo());
      }

      return UserInformationChangeNotifier();
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(toString());

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Flexible(
                flex: 1280,
                child: LayoutBuilder(builder: (context, constraints) {
                  final bool isDesktopStyle = screenWidthWithoutContext()
                      .determineScreenStyle()
                      .isDesktopStyle;

                  return Container(
                    constraints: const BoxConstraints(maxWidth: 1280),
                    padding: EdgeInsets.only(
                        top: isDesktopStyle
                            ? kToolbarDesktopHeight + 100
                            : kToolbarMobileHeight + 24,
                        bottom: isDesktopStyle ? 48 : 20,
                        left: 20,
                        right: 20),
                    child: Container(
                      clipBehavior: Clip.hardEdge, // 超出的部分，裁剪掉
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Column(
                        children: [
                          isDesktopStyle
                              ? const _AvatarWidget(ScreenStyle.desktop)
                              : const _AvatarWidget(ScreenStyle.mobile),
                          const _InformationDescriptionWidget(),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              const Spacer(),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 24),
            child: context.isDesktop
                ? UniversalLinkQRCode(
                    str: ServerConst.routerHost + widget.uri,
                  )
                : Column(
                    children: [
                      Text(
                        context.tr(QppLocales.commodityInfoLaunchQPP),
                        style: const TextStyle(
                            fontSize: 16, color: QppColor.platinum),
                      ),
                      const SizedBox(height: 24),
                      const OpenQppButton(),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

// 頭像Widget
class _AvatarWidget extends ConsumerWidget {
  const _AvatarWidget(this.screenStyle);

  final ScreenStyle screenStyle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint(toString());

    final isDesktopStyle = screenStyle == ScreenStyle.desktop;

    final userInformation = ref.watch(userInformationProvider);

    final userID = userInformation.userIDState.data;
    final qppUser = userInformation.infoState.data;

    final avaterIsError = userInformation.avaterIsError;
    final bgImageIsError = userInformation.bgImageIsError;

    return userID == null
        ? const SizedBox.shrink()
        : Container(
            height: isDesktopStyle ? 265 : 196,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: bgImageIsError
                    ? const AssetImage(
                            'desktop_pic_commodity_largepic_default.webp')
                        as ImageProvider
                    : NetworkImage(userInformation.bgImage),
                onError: (exception, stackTrace) => userInformation
                    .imageErrorToggle(style: QppImageStyle.backgroundImage),
              ),
            ),
            child: Stack(
              children: [
                ModalBarrier(
                  color: Colors.black.withOpacity(0.7),
                  dismissible: false,
                ), // 遮罩
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: isDesktopStyle ? 36 : 24),
                      SizedBox(
                        width: isDesktopStyle ? 100 : 88,
                        height: isDesktopStyle ? 100 : 88,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent, // 設置透明背景
                          backgroundImage: avaterIsError
                              ? const AssetImage(
                                      'desktop_pic_profile_avatar_default.png')
                                  as ImageProvider
                              : NetworkImage(userInformation.avaterImage),
                          onBackgroundImageError: (exception, stackTrace) =>
                              userInformation.imageErrorToggle(),
                        ),
                      ),
                      SizedBox(height: isDesktopStyle ? 20 : 12),
                      Text(
                        context.tr(qppUser?.displayName ??
                            QppLocales.errorPageNickname),
                        style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        userID.toString(),
                        style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 14,
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
class _InformationDescriptionWidget extends ConsumerWidget {
  const _InformationDescriptionWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('InformationDescriptionWidget build');

    final response =
        ref.watch(userInformationProvider.select((value) => value.infoState));

    return Container(
      width: double.infinity,
      color: const Color.fromRGBO(22, 32, 68, 1),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 60),
        child: ReadMoreText(
          context
              .tr(response.data?.displayInfo ?? QppLocales.errorPageInfoNotyet),
          textAlign: TextAlign.start,
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimExpandedText: '',
          trimCollapsedText: context.tr('commodity_info_more'),
          moreStyle:
              const TextStyle(fontSize: 18, color: QppColor.babyBlueEyes),
          style: const TextStyle(fontSize: 18, color: QppColor.platinum),
          linkTextStyle:
              const TextStyle(fontSize: 18, color: QppColor.mayaBlue),
          onLinkPressed: (String url) {
            url.launchURL();
          },
        ),
      ),
    );
  }
}
