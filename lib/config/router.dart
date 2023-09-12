import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:star_wars/constants/routes.dart';
import 'package:star_wars/models/character.dart';
import 'package:star_wars/screens/general/character_screen.dart';
import 'package:star_wars/screens/general/settings_screen.dart';
import 'package:star_wars/screens/general/web_view_screen.dart';
import 'package:star_wars/screens/splash_screen.dart';
import 'package:star_wars/screens/main/main_screen.dart';
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
    fluroRouter.define(Routes.main.toString(), handler: _mainScreenHandler);
    fluroRouter.define(Routes.settings.toString(),
        handler: _settingsScreenHandler);
    fluroRouter.define(Routes.character.toString(),
        handler: _characterScreenHandler);
    fluroRouter.define(Routes.webview.toString(),
        handler: _webviewScreenHandler);
  }

  static final _splashScreenHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return const SplashScreen();
  });

  static final _mainScreenHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return MainScreen();
  });

  static final _settingsScreenHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return const SettingsScreen();
  });

  static final _characterScreenHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    CharacterModel character = context?.settings?.arguments as CharacterModel;

    return CharacterScreen(
      character: character,
    );
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
