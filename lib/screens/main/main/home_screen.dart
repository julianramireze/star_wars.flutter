import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:star_wars/config/api.dart';
import 'package:star_wars/constants/assets.dart';
import 'package:star_wars/constants/routes.dart';
import 'package:star_wars/models/character.dart';
import 'package:star_wars/services/api.dart';
import 'package:star_wars/stores/character.dart';
import 'package:star_wars/utils/helpers/hooks.dart';
import 'package:star_wars/utils/helpers/request_state.dart';
import 'package:star_wars/widgets/character.dart';
import 'package:star_wars/widgets/custom_boxhsadow.dart';
import 'package:star_wars/widgets/custom_button.dart';
import 'package:star_wars/config/router.dart' as AppRouter;
import 'package:star_wars/widgets/custom_input.dart';
import 'package:star_wars/constants/colors.dart' as AppColors;
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive(wantKeepAlive: true);
    final scrollController = useScrollController();
    final focusNode = useFocusNode();
    final characterStore = Provider.of<CharacterStore>(context);
    final searchText = useState("");
    final page = useState(1);
    final charactersFiltered = useState([]);

    useAsyncEffect(() {
      page.value = (characterStore.characters.isEmpty
              ? 10
              : characterStore.characters.length) ~/
          10;
      characterStore.get(page.value);

      scrollController.addListener(() {
        if (scrollController.position.pixels ==
                scrollController.position.maxScrollExtent &&
            !characterStore.requestStateGet.loading) {
          if (characterStore.requestStateGet.success !=
              RequestStateSuccessType.none) {
            page.value = page.value + 1;
            characterStore.requestStateGet.clear();
          }
          characterStore.get(page.value);
        }
      });
      return;
    }, () {}, []);

    useAsyncEffect(() {
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
                        enabled: characterStore.characters.isNotEmpty,
                        height: 40,
                        focusNode: focusNode,
                        hideErrorOnFalse: true,
                        isClearable: true,
                        colorBackground: Colors.white,
                        colorShadow: Colors.transparent,
                        textColor: AppColors.Colors.black.withOpacity(0.8),
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
                            color: AppColors.Colors.black.withOpacity(0.8),
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
                  : characterStore.characters.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  tr(characterStore.requestStateGet.error ==
                                          RequestStateErrorType.noInternet
                                      ? "check_internet"
                                      : "try_later"),
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal)),
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: CustomButton(
                                  color: Theme.of(context).colorScheme.surface,
                                  padding: EdgeInsets.only(
                                      top: 10, bottom: 10, left: 20, right: 20),
                                  borderRadius: BorderRadius.circular(50),
                                  onTap: () {
                                    characterStore.get(page.value);
                                  },
                                  child: Text(tr("retry"),
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal)),
                                ),
                              )
                            ],
                          ),
                        )
                      : Stack(
                          children: [
                            ListView.builder(
                              physics: BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              controller: scrollController,
                              itemCount: charactersFiltered.value.length,
                              itemBuilder: (context, index) {
                                CharacterModel character =
                                    charactersFiltered.value[index];
                                final isFavorite = characterStore
                                    .charactersFavorites
                                    .any((characterFavorite) =>
                                        characterFavorite.name ==
                                        character.name);

                                return Character(
                                    character: character,
                                    isFavorite: isFavorite
                                        ? CharacterFavoriteType.favorite
                                        : CharacterFavoriteType.unfavorite,
                                    isReported: CharacterReportType.none,
                                    onTap: () {
                                      AppRouter.Router.fluroRouter.navigateTo(
                                          context, Routes.character.toString(),
                                          routeSettings: RouteSettings(
                                              arguments: character),
                                          transition:
                                              TransitionType.inFromRight);
                                    });
                              },
                            ),
                            if (characterStore.requestStateGet.loading)
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  left: 0,
                                  child: Center(
                                    child: Lottie.asset(
                                      loadingAnimation,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.fill,
                                    ),
                                  ))
                          ],
                        ),
            ))
          ]),
        ));
  }
}
