import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/api/core/http_service.dart';
import 'package:qpp_example/qpp_app_bar/qpp_app_bar_view.dart';
import 'package:qpp_example/qpp_info_body/view/qpp_info_body_main.dart';
import 'package:qpp_example/utils/screen.dart';

void main() {
  HttpService service = HttpService.instance;
  service.initDio();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  final StateNotifierProvider<FullScreenMenuBtnPageStateNotifier, bool>
      fullScreenMenuBtnPageStateProvider = StateNotifierProvider((ref) {
    return FullScreenMenuBtnPageStateNotifier();
  });

  @override
  Widget build(BuildContext context) {

    debugPrint('MyHomePage build');

    return ProviderScope(
      child: Stack(
        children: [
          Scaffold(
            extendBodyBehindAppBar: true, // 設定可以在appBar後面擴充body
            appBar: qppAppBar(fullScreenMenuBtnPageStateProvider),
            body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('desktop_bg_kv.png'),
                ),
              ),
              child: InformationOuterFrame(
                userID: 886900100106,
              ),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          ),
          FullScreenMenuBtnPage(fullScreenMenuBtnPageStateProvider),
        ],
      ),
    );
  }
}
