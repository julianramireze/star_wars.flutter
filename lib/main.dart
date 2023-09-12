import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:star_wars/config/key.dart' as Config;
import 'package:star_wars/config/router.dart' as AppRouter;
import 'package:star_wars/config/themes/theme_dark.dart';
import 'package:star_wars/config/themes/theme_light.dart';
import 'package:star_wars/constants/colors.dart' as AppColors;
import 'package:star_wars/constants/routes.dart';
import 'package:star_wars/stores/character.dart';
import 'package:star_wars/stores/planet.dart';
import 'package:star_wars/stores/settings.dart';
import 'package:star_wars/stores/starship.dart';
import 'package:star_wars/stores/vehicle.dart';
import 'package:star_wars/utils/helpers/local_storage_service.dart';
import 'package:microsoft_azure_translator/microsoft_azure_translator.dart';

void main() async {
  //prepare
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  AppRouter.Router.setupRouter();
  await LocalStorageService().setup();
  MicrosoftAzureTranslator.initialize(
      Config.Key.azureTranslationSubscriptionKey,
      Config.Key.azureTranslationRegion);

  //setup
  final settingsStore = SettingsStore();
  await settingsStore.init();

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
        ChangeNotifierProvider(create: (_) => settingsStore),
      ], child: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.Colors.black,
    ));

    final settingsStore = Provider.of<SettingsStore>(context);

    return DefaultTextHeightBehavior(
        textHeightBehavior: const TextHeightBehavior(),
        child: MaterialApp(
          title: "Star Wars",
          theme: settingsStore.darkMode ? themeDark : themeLight,
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.splash.toString(),
          onGenerateRoute: AppRouter.Router.fluroRouter.generator,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        ));
  }
}
