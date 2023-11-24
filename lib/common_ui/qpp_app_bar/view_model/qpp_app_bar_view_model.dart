import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 是否顯示全螢幕選單Provider
final StateNotifierProvider<IsOpenAppBarMenuBtnPageStateNotifier, bool>
    isOpenAppBarMenuBtnPageProvider =
    StateNotifierProvider((ref) => IsOpenAppBarMenuBtnPageStateNotifier());

/// 是否顯示全螢幕選單Notifier
class IsOpenAppBarMenuBtnPageStateNotifier extends StateNotifier<bool> {
  IsOpenAppBarMenuBtnPageStateNotifier() : super(false);

  void toggle() {
    state = !state;
  }
}

/// 滑鼠狀態Notifier
class MouseRegionStateNotifier extends StateNotifier<PointerEvent> {
  MouseRegionStateNotifier() : super(const PointerExitEvent());

  void onEnter() {
    state = const PointerEnterEvent();
  }

  void onExit() {
    state = const PointerExitEvent();
  }
}
