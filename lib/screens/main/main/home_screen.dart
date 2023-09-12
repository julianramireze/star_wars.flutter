import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:star_wars/constants/assets.dart';
import 'package:star_wars/constants/routes.dart';
import 'package:star_wars/models/character.dart';
import 'package:star_wars/stores/character.dart';
import 'package:star_wars/utils/helpers/hooks.dart' as CustomHooks;
import 'package:star_wars/widgets/character.dart';
import 'package:star_wars/widgets/custom_boxhsadow.dart';
import 'package:star_wars/widgets/custom_button.dart';
import 'package:star_wars/config/router.dart' as AppRouter;
import 'package:star_wars/widgets/custom_input.dart';
import 'package:star_wars/widgets/internet_checker.dart';
import 'package:star_wars/constants/colors.dart' as AppColors;
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomHooks.useAutomaticKeepAlive(wantKeepAlive: true);
    final focusNode = useFocusNode();
    final characterStore = Provider.of<CharacterStore>(context);
    final searchText = useState("");
    final page = useState(1);
    final charactersFiltered = useState([]);

    CustomHooks.useAsyncEffect(() {
      characterStore.get(page.value);
      return;
    }, () {}, []);

    CustomHooks.useAsyncEffect(() {
      if (searchText.value != "") {
        charactersFiltered.value = characterStore.characters
            .where((character) => character.name
                .toLowerCase()
                .contains(searchText.value.toLowerCase()))
            .toList();
      } else {
        charactersFiltered.value = characterStore.characters;
      }
    }, () {}, [
      characterStore.characters,
      characterStore.charactersFavorites,
      characterStore.charactersReported,
      searchText.value
    ]);

    return CustomButton(
        padding: EdgeInsets.all(0),
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          resizeToAvoidBottomInset: true,
          body: Column(children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      CustomInput(
                        height: 40,
                        focusNode: focusNode,
                        hideErrorOnFalse: true,
                        isClearable: true,
                        colorBackground: Colors.white,
                        colorShadow: Colors.transparent,
                        textColor: Theme.of(context).colorScheme.onSurface,
                        colorClear: Colors.redAccent,
                        hint: tr("search"),
                        textInputType: TextInputType.name,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                        ],
                        onChange: (value) {
                          searchText.value = value;
                        },
                        contentPadding: EdgeInsets.only(
                            top: 10, bottom: 10, right: 45, left: 15),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 17),
                        hintStyle: TextStyle(
                            color: AppColors.Colors.gray, fontSize: 15),
                        borderRadius: BorderRadius.circular(50),
                        onClear: () {
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                    child: characterStore.requestStateGet.loading &&
                            characterStore.characters.isEmpty
                        ? Center(
                            child: Lottie.asset(
                            loadingAnimation,
                            width: 50,
                            height: 50,
                            fit: BoxFit.fill,
                          ))
                        : ListView.builder(
                            physics: BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            itemCount: charactersFiltered.value.length,
                            itemBuilder: (context, index) {
                              CharacterModel character =
                                  charactersFiltered.value[index];
                              var finded = characterStore.charactersFavorites
                                  .any((characterFavorite) =>
                                      characterFavorite.name == character.name);
                              return Character(
                                character: character,
                                isFavorite: finded
                                    ? CharacterFavoriteType.favorite
                                    : CharacterFavoriteType.unfavorite,
                                isReported: CharacterReportType.none,
                                onTap: () {
                                  AppRouter.Router.fluroRouter.navigateTo(
                                      context, Routes.character.toString(),
                                      routeSettings:
                                          RouteSettings(arguments: character),
                                      transition: TransitionType.inFromRight);
                                },
                              );
                            },
                          )))
          ]),
        ));
  }
}
