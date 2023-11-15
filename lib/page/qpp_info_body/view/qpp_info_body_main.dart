import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/api/podo/core/base_response.dart';
import 'package:qpp_example/common_ui/qpp_qrcode.dart';
import 'package:qpp_example/page/qpp_info_body/view_model/qpp_info_body_view_model.dart';
import 'package:qpp_example/utils/qpp_image_utils.dart';

late ChangeNotifierProvider<UserSelectInfoChangeNotifier>
    userSelectInfoProvider;

class InformationOuterFrame extends StatefulWidget {
  const InformationOuterFrame({super.key, required this.userID});

  final String userID;

  @override
  State<InformationOuterFrame> createState() => _InformationOuterFrameState();
}

class _InformationOuterFrameState extends State<InformationOuterFrame> {
  @override
  void initState() {
    super.initState();

    userSelectInfoProvider =
        ChangeNotifierProvider<UserSelectInfoChangeNotifier>((ref) {
      int? userID = int.tryParse(widget.userID);

      if (userID != null) {
        Future.microtask(() => ref.notifier.getUserInfo(userID));
        Future.microtask(() => ref.notifier.getUserImage(userID));
        Future.microtask(() => ref.notifier
            .getUserImage(userID, style: QppImageStyle.backgroundImage));
      }

      return UserSelectInfoChangeNotifier();
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(toString());

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              const Spacer(),
              Expanded(
                flex: 10,
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 1280),
                    padding: const EdgeInsets.only(
                        top: 180, bottom: 48, left: 20, right: 20),
                    child: Container(
                      clipBehavior: Clip.hardEdge, // 超出的部分，裁剪掉
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Column(
                        children: [
                          AvatarWidget(
                            userSelectInfoProvider: userSelectInfoProvider,
                            userID: widget.userID,
                          ),
                          const InformationDescriptionWidget(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 89),
            child: UniversalLinkQRCode(
              str:
                  "https://qpptec.com/app/information?phoneNumber=${widget.userID}&lang=zh_TW",
            ),
          ),
        ],
      ),
    );
  }
}

// 頭像Widget
class AvatarWidget extends ConsumerWidget {
  const AvatarWidget(
      {super.key, required this.userSelectInfoProvider, required this.userID});

  final String userID;

  final ChangeNotifierProvider<UserSelectInfoChangeNotifier>
      userSelectInfoProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('AvatarWidget build');

    final notifier = ref.watch(userSelectInfoProvider);

    final infoResponse = notifier.infoState.data;

    final avatarResponse = notifier.avaterState.data;
    String avatar = QppImageUtils.getUserImageURL(int.tryParse(userID) ?? 0,
        timestamp:
            avatarResponse?.getUserImageResponse.lastModifiedTimestamp ?? 0);
    final avaterIsError = notifier.avaterIsError;

    final bgResponse = notifier.bgImageState.data;
    String bgImage = QppImageUtils.getUserImageURL(int.tryParse(userID) ?? 0,
        imageStyle: QppImageStyle.backgroundImage,
        timestamp: bgResponse?.getUserImageResponse.lastModifiedTimestamp ?? 0);
    final bgImageIsError = notifier.bgImageIsError;

    return Container(
      height: 265,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: bgImageIsError
              ? const AssetImage('assets/desktop_pic_commodity_largepic_default.webp')
                  as ImageProvider
              : NetworkImage(bgImage),
          onError: (exception, stackTrace) =>
              notifier.imageErrorToggle(style: QppImageStyle.backgroundImage),
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
                const SizedBox(height: 36),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent, // 設置透明背景
                    backgroundImage: avaterIsError
                        ? const AssetImage(
                                'assets/desktop_pic_profile_avatar_default.png')
                            as ImageProvider
                        : NetworkImage(avatar),
                    onBackgroundImageError: (exception, stackTrace) =>
                        notifier.imageErrorToggle(),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  infoResponse?.userSelectInfoResponse.nameStr ?? '暱稱',
                  style: const TextStyle(
                    color: Colors.amber,
                    fontSize: 28,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  userID,
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
  const InformationDescriptionWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('InformationDescriptionWidget build');

    final response =
        ref.watch(userSelectInfoProvider.select((value) => value.infoState));

    final String text =
        response.data?.userSelectInfoResponse.infoStr ?? '尚未新增簡介';
    const TextStyle textStyle = TextStyle(fontSize: 18, color: Colors.white);
    // final double textH = text.height(textStyle, context);

    return Container(
      width: double.infinity,
      color: const Color.fromRGBO(22, 32, 68, 1),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 60),
        child: Text(text, style: textStyle),
      ),
    );
  }
}
