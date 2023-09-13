import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:star_wars/constants/colors.dart' as AppColors;
import 'package:star_wars/config/router.dart' as AppRouter;
import 'package:star_wars/stores/settings.dart';
import 'package:star_wars/utils/helpers/device_info.dart';
import 'package:star_wars/utils/helpers/hooks.dart';

enum SettingType { switcher, dropdown }

class Setting {
  final String title;
  final String subtitle;
  final SettingType type;
  final bool value;
  final String selectedOption;
  final List<String> options;
  final Function? onChange;
  final Function? onChangeDropdown;

  Setting(
      {required this.title,
      required this.subtitle,
      required this.type,
      required this.value,
      required this.selectedOption,
      required this.options,
      this.onChange,
      this.onChangeDropdown});
}

class SettingsScreen extends HookWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    final version = useState("1.0.0");
    final settings = useState(<Setting>[]);

    Future<bool> _onWillPop() async {
      AppRouter.Router.popRoute(context);
      return false;
    }

    useAsyncEffect(() {
      settingsStore.setLanguage(context.locale.toString());

      (() async {
        final versionGetted = await DeviceInfo().getVersionApp();
        version.value = versionGetted;
      })();

      return;
    }, () {}, []);

    useAsyncEffect(() {
      settings.value = <Setting>[
        Setting(
            title: "language",
            subtitle: "select_language",
            type: SettingType.dropdown,
            value: false,
            selectedOption: context.locale.toString(),
            options: ["en", "es"],
            onChangeDropdown: (value) {
              settingsStore.setLanguage(value!);
            }),
        Setting(
            title: "dark_mode",
            subtitle: "dark_mode_subtitle",
            type: SettingType.switcher,
            value: settingsStore.darkMode,
            selectedOption: "",
            options: [],
            onChange: (value) {
              settingsStore.toggleDarkMode();
            }),
        Setting(
            title: "connection",
            subtitle: "connection_subtitle",
            type: SettingType.switcher,
            value: settingsStore.connectionEnabled,
            selectedOption: "",
            options: [],
            onChange: (value) {
              settingsStore.toggleConnection();
            }),
      ];
    }, () {}, [
      settingsStore.language,
      settingsStore.darkMode,
      settingsStore.connectionEnabled
    ]);

    useAsyncEffect(() {
      context.setLocale(Locale(settingsStore.language));
    }, () {}, [settingsStore.language]);

    return SafeArea(
        child: WillPopScope(
            onWillPop: _onWillPop,
            child: Scaffold(
                backgroundColor: Theme.of(context).colorScheme.background,
                resizeToAvoidBottomInset: true,
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 10, top: 20, bottom: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                splashRadius: 1,
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Theme.of(context).colorScheme.surface,
                                  size: 22,
                                ),
                                onPressed: () {
                                  AppRouter.Router.popRoute(context);
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(tr("settings.title"),
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Container(
                                width: 45,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          itemCount: settings.value.length,
                          itemBuilder: (context, index) {
                            final setting = settings.value[index];
                            return Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10),
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Text(
                                                tr("settings." + setting.title),
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          SizedBox(
                                              width: 230,
                                              child: Text(
                                                  tr("settings." +
                                                      setting.subtitle),
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurface,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400)))
                                        ],
                                      ),
                                      setting.type == SettingType.switcher
                                          ? Switch(
                                              value: setting.value,
                                              onChanged: (value) {
                                                if (setting.onChange != null) {
                                                  setting.onChange!(value);
                                                }
                                              })
                                          : DropdownButton<String>(
                                              value: setting.selectedOption,
                                              icon: Icon(
                                                Icons.arrow_drop_down_rounded,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface,
                                              ),
                                              iconSize: 24,
                                              elevation: 16,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary),
                                              underline: Container(
                                                height: 0,
                                                color: Colors.transparent,
                                              ),
                                              onChanged: (String? newValue) {
                                                if (setting.onChangeDropdown !=
                                                    null) {
                                                  setting.onChangeDropdown!(
                                                      newValue);
                                                }
                                              },
                                              items: setting.options.map<
                                                      DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                      tr("languages." + value)),
                                                );
                                              }).toList(),
                                            )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Text("v${version.value}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400)),
                    )
                  ],
                ))));
  }
}
