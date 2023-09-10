import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:star_wars/config/router.dart' as AppRouter;
import 'package:star_wars/config/themes/theme_dark.dart';
import 'package:star_wars/config/themes/theme_light.dart';
import 'package:star_wars/constans/colors.dart' as AppColors;
import 'package:star_wars/constans/routes.dart';
import 'package:star_wars/stores/character.dart';
import 'package:star_wars/stores/planet.dart';
import 'package:star_wars/stores/settings.dart';
import 'package:star_wars/stores/starship.dart';
import 'package:star_wars/stores/vehicle.dart';
import 'package:star_wars/utils/ui/helpers/local_storage_service.dart';

void main() async {
  //prepare
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  AppRouter.Router.setupRouter();
  await LocalStorageService().setup();

  //run
  runApp(EasyLocalization(
      supportedLocales: const [Locale('es'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => CharacterStore()),
        ChangeNotifierProvider(create: (_) => PlanetStore()),
        ChangeNotifierProvider(create: (_) => VehicleStore()),
        ChangeNotifierProvider(create: (_) => StarShipStore()),
      ], child: MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.Colors.black,
    ));
    return DefaultTextHeightBehavior(
        textHeightBehavior: const TextHeightBehavior(),
        child: ChangeNotifierProvider(
            create: (context) => SettingsStore(),
            builder: (context, _) {
              final settingsStore = Provider.of<SettingsStore>(context);
              return MaterialApp(
                title: "Star Wars",
                theme: settingsStore.darkMode ? themeDark : themeLight,
                debugShowCheckedModeBanner: false,
                initialRoute: Routes.splash.toString(),
                onGenerateRoute: AppRouter.Router.fluroRouter.generator,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
              );
            }));
  }
}
