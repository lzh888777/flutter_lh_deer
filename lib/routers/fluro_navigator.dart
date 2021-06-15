import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lh_deer/routers/routers.dart';

class NavigatorUtils {
  static void push(BuildContext context, String path,
      {bool replace = false, bool clearStack = false, Object? arguments}) {
    unfocus();
    print("push " + path);
    Routes.router.navigateTo(
      context,
      path,
      replace: replace,
      clearStack: clearStack,
      transition: TransitionType.native,
      routeSettings: RouteSettings(arguments: arguments),
    );
    print("push ----");
  }

  static void unfocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
