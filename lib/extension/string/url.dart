import 'package:url_launcher/url_launcher.dart';

extension UrlExtension on String {
  /// 啟動URL
launchURL() async {
  final Uri url = Uri.parse(this);

  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
}