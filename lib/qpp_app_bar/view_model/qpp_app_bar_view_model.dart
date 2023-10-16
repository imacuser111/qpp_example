import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 全螢幕按鈕選單狀態
class FullScreenMenuBtnPageStateNotifier extends StateNotifier<bool> {
  FullScreenMenuBtnPageStateNotifier() : super(false);

  void toggle() {
    state = !state; // 是否顯示全螢幕選單
  }
}

/// 滑鼠狀態
class MouseRegionStateNotifier extends StateNotifier<PointerEvent> {
  MouseRegionStateNotifier() : super(const PointerExitEvent());

  void onEnter() {
    state = const PointerEnterEvent();
  }

  void onExit() {
    state = const PointerExitEvent();
  }
}
