import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DynamicLinksService {
  static Future<void> initDynamicLinks() async {
    // NOTE: Listen for terminated state
    // Get any initial links
    final PendingDynamicLinkData? _initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (_initialLink != null) {
      _handleDynamicLink(_initialLink);
    }

    // NOTE: Listen for background / foreground state
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLink) {
      _handleDynamicLink(dynamicLink);
    }).onError((error) {
      debugPrint(error);
    });
  }

  static void _handleDynamicLink(PendingDynamicLinkData dynamicLink) async {
    final Uri _deepLink = dynamicLink.link;

    // Show message in debug
    debugPrint(_deepLink.toString());
    Fluttertoast.showToast(
      msg: _deepLink.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      fontSize: 16.0,
    );
  }
}
