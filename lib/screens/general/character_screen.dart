import 'package:easy_localization/easy_localization.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:microsoft_azure_translator/microsoft_azure_translator.dart';
import 'package:provider/provider.dart';
import 'package:star_wars/config/api.dart';
import 'package:star_wars/constants/routes.dart';
import 'package:star_wars/models/character.dart';
import 'package:star_wars/config/router.dart' as AppRouter;
import 'package:star_wars/stores/character.dart';
import 'package:star_wars/stores/settings.dart';
import 'package:star_wars/utils/helpers/hooks.dart';
import 'package:star_wars/utils/helpers/request_state.dart';
import 'package:star_wars/widgets/character.dart';
import 'package:star_wars/widgets/custom_boxhsadow.dart';
import 'package:star_wars/widgets/custom_button.dart';
import 'package:star_wars/constants/colors.dart' as AppColors;
import 'package:star_wars/widgets/custom_toast.dart';

class CharacterScreen extends HookWidget {
  final CharacterModel character;

  const CharacterScreen({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final characterStore = Provider.of<CharacterStore>(context);
    final settingsStore = Provider.of<SettingsStore>(context);
    final isFavorite = characterStore.charactersFavorites
        .any((characterFavorite) => characterFavorite.name == character.name);
    final isReported = characterStore.charactersReported
        .any((characterReported) => characterReported.name == character.name);
    final gender =
        Gender.StringToGender(character.gender, settingsStore.darkMode);
    final translations = useState({
      "hair_color": character.hairColor,
      "eye_color": character.eyeColor,
    });

    Future<bool> _onWillPop() async {
      AppRouter.Router.popRoute(context);
      return false;
    }

    useAsyncEffect(() {
      (() async {
        Map<String, String> newTranslations = {};

        for (String translationKey in translations.value.keys) {
          final translationItem = translations.value[translationKey] ?? "";
          List<dynamic>? AzureTranslation = await MicrosoftAzureTranslator
              .instance
              .translate(translationItem, "en", context.locale.languageCode);

          if (AzureTranslation != null && AzureTranslation.isNotEmpty) {
            newTranslations[translationKey] =
                AzureTranslation[0]['text'].substring(0, 1).toUpperCase() +
                    AzureTranslation[0]['text'].substring(1);
          } else {
            newTranslations[translationKey] = translationItem.toUpperCase() +
                translationItem.substring(1).toLowerCase();
          }
        }

        translations.value = newTranslations;
      })();
    }, () {}, []);

    useAsyncEffect(() {
      if (characterStore.requestStateReport.success !=
          RequestStateSuccessType.none) {
        CustomToast(context,
                icon: const Icon(
                  Icons.error_outlined,
                  color: AppColors.Colors.black,
                ),
                text: tr("success_report"),
                bottom: MediaQuery.of(context).size.height * 0.6,
                backgroundColor: settingsStore.darkMode
                    ? Colors.greenAccent
                    : Colors.green[400]!,
                textStyle: const TextStyle(
                    fontSize: 14, color: AppColors.Colors.black))
            .show();
      }

      if (characterStore.requestStateReport.error !=
          RequestStateErrorType.none) {
        CustomToast(context,
                icon: const Icon(
                  Icons.error_rounded,
                  color: AppColors.Colors.black,
                ),
                text: characterStore.requestStateReport.error ==
                        RequestStateErrorType.noInternet
                    ? tr("check_internet")
                    : tr("try_later"),
                bottom: MediaQuery.of(context).size.height * 0.6,
                backgroundColor: settingsStore.darkMode
                    ? Colors.redAccent
                    : Colors.red[400]!,
                textStyle:
                    TextStyle(fontSize: 14, color: AppColors.Colors.black))
            .show();
      }

      characterStore.requestStateReport.clear();
    }, () => {}, [
      characterStore.requestStateReport.success,
      characterStore.requestStateReport.error
    ]);

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
                          left: 15, right: 20, top: 20, bottom: 5),
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
                                  Text(character.name,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              CustomBoxShadow(
                                  padding: const EdgeInsets.all(4),
                                  radius: 50,
                                  margin: EdgeInsets.only(left: 12),
                                  colorBackground:
                                      Colors.white.withOpacity(0.2),
                                  colorShadow: Colors.transparent,
                                  child: CustomButton(
                                      onTap: () {
                                        AppRouter.Router.fluroRouter.navigateTo(
                                            context, Routes.webview.toString(),
                                            transition:
                                                TransitionType.inFromRight,
                                            routeSettings:
                                                RouteSettings(arguments: {
                                              "url":
                                                  "${Api.getServerGoogle}search?q=${Uri.encodeComponent("${character.name} star wars")}",
                                              "title": tr("more_information")
                                            }));
                                      },
                                      borderRadius: BorderRadius.circular(100),
                                      padding: const EdgeInsets.all(0),
                                      child: Icon(
                                        Icons.image_search_rounded,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        size: 25,
                                      ))),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 30, bottom: 30),
                              width: 145,
                              height: 145,
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(100)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  "character.image",
                                  fit: BoxFit.cover,
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Container(
                                      width: 135,
                                      height: 135,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary
                                              .withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Center(
                                        child: Icon(
                                          Icons.person,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          size: 50,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 102.5,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.2),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                            child: SingleChildScrollView(
                          child: Container(
                              margin:
                                  const EdgeInsets.only(left: 25, right: 25),
                              child: Column(children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 5),
                                              child: Text(
                                                tr("height") + " (cm)",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Text(
                                              character.height.toString(),
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onBackground,
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 5),
                                              child: Text(
                                                tr("mass") + " (kg)",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Text(
                                              character.mass.toString(),
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onBackground,
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                      ]),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 40),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Text(
                                              tr("hair_color"),
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Text(
                                            translations.value["hair_color"] ??
                                                character.hairColor,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Text(
                                              tr("eye_color"),
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Text(
                                            translations.value["eye_color"] ??
                                                character.eyeColor,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 40),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Text(
                                              tr("gender"),
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Text(
                                            tr("genders.${gender.gender}"),
                                            style: TextStyle(
                                                color: gender.color,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Text(
                                              tr("birth_year"),
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Text(
                                            character.birthYear,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ])),
                        )),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 15, bottom: 15),
                              child: CustomButton(
                                onTap: () {
                                  if (!characterStore
                                      .requestStateReport.loading) {
                                    if (isReported) {
                                      characterStore
                                          .removeCharacterReported(character);
                                    } else {
                                      characterStore.report(character);
                                    }
                                  }
                                },
                                color: isReported
                                    ? Theme.of(context).colorScheme.surface
                                    : Colors.redAccent,
                                disabledColor:
                                    Theme.of(context).colorScheme.onBackground,
                                enabled: settingsStore.connectionEnabled,
                                showInk:
                                    !characterStore.requestStateReport.loading,
                                loading:
                                    characterStore.requestStateReport.loading,
                                borderRadius: BorderRadius.circular(5),
                                padding: const EdgeInsets.all(0),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width - 40,
                                  height: 40,
                                  child: Text(
                                    tr(isReported ? "unreport" : "report"),
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )),
                  ],
                ))));
  }
}
