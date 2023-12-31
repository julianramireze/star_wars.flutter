// ignore_for_file: prefer_function_declarations_over_variables, unnecessary_null_comparison, prefer_const_constructors

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:star_wars/constants/colors.dart' as AppColors;
import 'package:lottie/lottie.dart';
import 'package:star_wars/constants/assets.dart';
import 'package:star_wars/constants/routes.dart';
import 'package:star_wars/stores/character.dart';
import 'package:star_wars/stores/planet.dart';
import 'package:star_wars/stores/settings.dart';
import 'package:star_wars/stores/starship.dart';
import 'package:star_wars/stores/vehicle.dart';
import 'package:star_wars/utils/helpers/hooks.dart';
import 'package:star_wars/config/router.dart' as AppRouter;

class SplashScreen extends HookWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    final characterStore = Provider.of<CharacterStore>(context);
    final planetStore = Provider.of<PlanetStore>(context);
    final starShipStore = Provider.of<StarShipStore>(context);
    final vehicleStore = Provider.of<VehicleStore>(context);

    useAsyncEffect(() {
      () async {
        await characterStore.init();
        await planetStore.init();
        await starShipStore.init();
        await vehicleStore.init();

        await Future.delayed(const Duration(seconds: 2));

        AppRouter.Router.fluroRouter.navigateTo(
          context,
          Routes.main.toString(),
          transition: TransitionType.fadeIn,
          replace: true,
        );
      }();

      return;
    }, () {}, []);

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Stack(children: [
          Center(
            child: Image.asset(
              logo,
              height: 175,
              width: 175,
            ),
          ),
          Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Lottie.asset(
                  loadingAnimation,
                  width: 74,
                  height: 74,
                  fit: BoxFit.fill,
                )
              ]))
        ]));
  }
}
