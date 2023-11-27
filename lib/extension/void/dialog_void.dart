import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qpp_example/common_ui/qpp_dialog/c_actions_dialog.dart';
import 'package:qpp_example/common_ui/qpp_dialog/c_image_dialog.dart';
import 'package:qpp_example/common_ui/qpp_dialog/open_qpp_dialog.dart';
import 'package:qpp_example/common_ui/qpp_dialog/qrcode_dialog.dart';
import 'package:qpp_example/common_view_model/auth_service/view_model/auth_service_view_model.dart';
import 'package:qpp_example/extension/build_context.dart';
import 'package:qpp_example/utils/shared_Prefs.dart';

/// 對話框擴充
extension DialogVoid on void {
  /// 顯示登入投票對話框
  void showloginVoteDialog(BuildContext context, {String url = ""}) {
    showDialog(
      context: context,
      builder: (context) {
        final text = context.tr('commodity_info_vote_login');
        final subText = context.tr('commodity_info_vote_login_p');
        final timerText =
            '${context.tr('commodity_info_countdown')}%s${context.tr('commodity_info_seconds')}';

        // showDialog要加上center不然他不知道位置，會導致設定的寬高的失效
        return Center(
          child: !context.isDesktopPlatform
              ? QRCodeDialog(
                  text: text,
                  subText: subText,
                  url: url,
                  timerText: timerText,
                )
              : OpenQppDialog(
                  text: text,
                  subText: subText,
                  timerText: timerText,
                ),
        );
      },
    );
  }

  /// 顯示投票成功對話框
  void showVoteSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        final isDesktopPlatform = context.isDesktopPlatform;

        // showDialog要加上center不然他不知道位置，會導致設定的寬高的失效
        return Center(
          child: CImageDialog(
            height: isDesktopPlatform ? 403 : 379,
            width: isDesktopPlatform ? 780 : 327,
            image: 'pic-successful.svg',
            text: context.tr('commodity_info_vote_success'),
            subText: context.tr('commodity_info_vote_success_p'),
          ),
        );
      },
    );
  }

  /// 顯示投票失敗對話框
  void showVoteFailureDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        final isDesktopPlatform = context.isDesktopPlatform;

        // showDialog要加上center不然他不知道位置，會導致設定的寬高的失效
        return Center(
          child: CImageDialog(
            height: isDesktopPlatform ? 403 : 379,
            width: isDesktopPlatform ? 780 : 327,
            image: 'pic-fail.svg',
            text: context.tr('commodity_info_vote_fault'),
            subText: 'subText',
          ),
        );
      },
    );
  }

  /// 顯示登出對話框
  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        final isDesktopPlatform = context.isDesktopPlatform;

        // showDialog要加上center不然他不知道位置，會導致設定的寬高的失效
        return Consumer(builder: (context, ref, child) {
          return Center(
            child: CActionsDialog(
              height: isDesktopPlatform ? 217 : 210,
              width: isDesktopPlatform ? 540 : 327,
              text: context.tr('alert_logout'),
              subText: context.tr('alert_logoutTip'),
              actions: [
                CDialogAction(
                  style: CDialogActionStyle.cancel,
                  callback: () => context.pop(),
                ),
                CDialogAction(
                  style: CDialogActionStyle.logout,
                  callback: () {
                    ref
                        .read(authServiceProvider.notifier)
                        .logout(SharedPrefs.getLoginInfo()?.vendorToken ?? "");
                    context.pop();
                  },
                )
              ],
            ),
          );
        });
      },
    );
  }
}
