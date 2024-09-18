import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> myLaunchURL(String url) async {
  debugPrint('Attempting to launch URL: $url');
  final uri = Uri.parse(url);

  try {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
      debugPrint('Successfully launched URL: $url');
      return true;
    }
  } on Exception catch (e) {
    debugPrint('Failed to launch URL: $url. Error: $e');
  }

  return false;
}
