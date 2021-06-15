import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lh_deer/home/home_page.dart';
import 'package:flutter_lh_deer/home/webview_page.dart';
import 'package:flutter_lh_deer/login/login_router.dart';
import 'package:flutter_lh_deer/routers/i_router.dart';
import 'package:flutter_lh_deer/routers/not_found_page.dart';

class Routes {
  static String home = '/home';
  static String webViewPage = '/webView';
  static final List<IRouterProvider> _listRouter = [];
  static final FluroRouter router = FluroRouter();
  static void initRoutes() {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      debugPrint('未找到目标页面');
      return const NotFoundPage();
    });

    router.define(home,
        handler: Handler(
            handlerFunc:
                (BuildContext? context, Map<String, List<String>> params) =>
                    const Home()));
    router.define(webViewPage, handler: Handler(handlerFunc: (_, params) {
      final String title = params['title']?.first ?? '';
      final String url = params['url']?.first ?? '';
      return WebViewPage(title: title, url: url);
    }));
    _listRouter.clear();

    _listRouter.add(LoginRouter());

    _listRouter.forEach((element) {
      element.initRouter(router);
    });
  }
}
