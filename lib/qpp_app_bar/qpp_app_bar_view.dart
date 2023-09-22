import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qpp_example/qpp_app_bar/qpp_app_bar_model.dart';
import 'package:qpp_example/qpp_app_bar/qpp_app_bar_view_model.dart';
import 'package:qpp_example/screen_model.dart';

AppBar qppAppBar() {
  return AppBar(
    toolbarHeight: 100,
    backgroundColor: const Color(0xff000b2b).withOpacity(0.6),
    title: const QppAppBarTitle(),
  );
}

class QppAppBarTitle extends StatelessWidget {
  const QppAppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('1231311');

    final size = MediaQuery.of(context).size;
    final viewModel =
        Provider.of<QppAppBarTitleViewModel>(context, listen: false);

    return Row(
      children: [
        // 左邊間距
        spacing(size.width, 321),
        logo(size.width),
        // QPP -> Button 間距
        spacing(size.width, 466),
        menuRow(size.width),
        languageDropdownMenu(viewModel),
      ],
    );
  }
}

extension QppAppBarTitleExtension on QppAppBarTitle {
  // 是否為小排版
  bool isSmallTypesetting(double width) => width < 800;

  /// 間距
  Widget spacing(double screenWidth, double width) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 10, maxWidth: width),
      child: SizedBox(
        width: getRealWidth(screenWidth, width),
      ),
    );
  }

  /// QPP Logo
  Widget logo(double width) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 100, maxWidth: 148),
      child: Image.asset(
        'desktop-pic-qpp-logo-01.png',
        width: getRealWidth(width, 148),
        scale: 46 / 148,
      ),
    );
  }

  /// 選單按鈕(Row)
  Widget menuRow(double width) {
    if (isSmallTypesetting(width)) {
      return const Spacer();
    }

    return Row(
      key: key,
      children: MainMenu.values
          .map(
            (e) => TextButton(
              onPressed: () => debugPrint(e.value),
              child: Text(
                e.value,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          )
          .toList(),
    );
  }

  /// 語系下拉選單
  Widget languageDropdownMenu(QppAppBarTitleViewModel viewModel) {
    MenuController menuController = MenuController();

    // Item
    List<DropdownMenuItem<String>> items = Language.values
        .map((e) => DropdownMenuItem(
              value: e.value,
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: () {
                      menuController.close();
                      debugPrint(e.value);
                      // viewModel.toggleLanguageDropdownMenuState();
                    },
                    child: Text(
                      e.value,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ))
        .toList();

    return MenuAnchor(
      builder: (context, controller, child) {
        menuController = controller;
        
        return IconButton(
          onPressed: () {
            controller.isOpen ? controller.close() : controller.open();
            // viewModel.toggleLanguageDropdownMenuState(listen: false);
          },
          icon: const Icon(Icons.language, color: Colors.white),
        );
      },
      menuChildren: items,
      style: MenuStyle(
        backgroundColor:
            MaterialStateProperty.all(const Color(0xff000b2b).withOpacity(0.6)),
      ),
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }
}
