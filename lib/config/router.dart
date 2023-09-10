import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:star_wars/constans/routes.dart';
import 'package:star_wars/screens/general/web_view_screen.dart';
import 'package:star_wars/screens/splash_screen.dart';
import 'package:star_wars/utils/ui/modals.dart';

class Router {
  static FluroRouter fluroRouter = FluroRouter();

  static void popRoute(context, {params = const {}}) {
    if (Navigator.canPop(context)) {
      fluroRouter.pop(context, params);
    } else {
      closeAppModal(context, () => Navigator.pop(context), () => exit(0))
          .show();
    }
  }

  static void setupRouter() {
    fluroRouter.define(Routes.splash.toString(), handler: _splashScreenHandler);
  }

  static final _splashScreenHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return const SplashScreen();
  });

  static final _webviewScreenHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    var args = context?.settings?.arguments != null
        ? context?.settings?.arguments as Map<String, dynamic>
        : null;

    return WebViewScreen(
      url: args?['url'],
      title: args?['title'],
    );
  });
}
