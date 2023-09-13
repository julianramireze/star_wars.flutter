import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:star_wars/constants/routes.dart';
import 'package:star_wars/models/character.dart';
import 'package:star_wars/stores/character.dart';
import 'package:star_wars/widgets/character.dart';
import 'package:star_wars/widgets/custom_button.dart';
import 'package:star_wars/constants/colors.dart' as AppColors;
import 'package:star_wars/utils/helpers/hooks.dart' as CustomHooks;
import 'package:star_wars/config/router.dart' as AppRouter;

class FavoritesScreen extends HookWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive(wantKeepAlive: true);
    final characterStore = Provider.of<CharacterStore>(context);

    return CustomButton(
        padding: EdgeInsets.all(0),
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          resizeToAvoidBottomInset: true,
          body: Column(children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: characterStore.charactersFavorites.length,
                      itemBuilder: (context, index) {
                        CharacterModel character =
                            characterStore.charactersFavorites[index];
                        return Character(
                            character: character,
                            isFavorite: CharacterFavoriteType.favorite,
                            isReported: CharacterReportType.none,
                            onTap: () {
                              AppRouter.Router.fluroRouter.navigateTo(
                                  context, Routes.character.toString(),
                                  routeSettings:
                                      RouteSettings(arguments: character),
                                  transition: TransitionType.inFromRight);
                            });
                      },
                    )))
          ]),
        ));
  }
}
