import 'package:easy_localization/easy_localization.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:star_wars/constants/routes.dart';
import 'package:star_wars/models/character.dart';
import 'package:star_wars/stores/character.dart';
import 'package:star_wars/widgets/custom_button.dart';
import 'package:star_wars/constants/colors.dart' as AppColors;
import 'package:star_wars/config/router.dart' as AppRouter;

enum CharacterFavoriteType { favorite, unfavorite, none }

enum CharacterReportType { report, unreported, none }

enum GenderType { male, female, hermaphrodite, unknown }

class Gender {
  final String gender;
  final Color color;

  Gender({required this.gender, required this.color});

  static Gender StringToGender(String gender) {
    late Gender finalGender;

    if (gender == GenderType.male.name) {
      finalGender =
          Gender(gender: GenderType.male.name, color: Colors.greenAccent);
    } else if (gender == GenderType.female.name) {
      finalGender =
          Gender(gender: GenderType.female.name, color: Colors.pinkAccent);
    } else if (gender == GenderType.hermaphrodite.name) {
      finalGender = Gender(
          gender: GenderType.hermaphrodite.name,
          color: Colors.deepPurpleAccent);
    } else {
      finalGender =
          Gender(gender: GenderType.unknown.name, color: Colors.orangeAccent);
    }

    return finalGender;
  }
}

class Character extends HookWidget {
  final CharacterModel character;
  final CharacterFavoriteType isFavorite;
  final CharacterReportType isReported;

  const Character(
      {Key? key,
      required this.character,
      required this.isFavorite,
      required this.isReported})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final characterStore = Provider.of<CharacterStore>(context);

    Gender gender = Gender.StringToGender(character.gender);

    return CustomButton(
        borderRadius: BorderRadius.circular(5),
        onTap: () {
          AppRouter.Router.fluroRouter.navigateTo(
              context, Routes.character.toString(),
              routeSettings: RouteSettings(arguments: character),
              transition: TransitionType.inFromRight);
        },
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://upload.wikimedia.org/wikipedia/commons/7/70/Example.png"),
                        fit: BoxFit.fill),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Text(character.name,
                            maxLines: 1,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 14,
                                fontWeight: FontWeight.normal)),
                      ),
                      Text(tr("genders." + gender.gender),
                          maxLines: 1,
                          style: TextStyle(
                              color: gender.color,
                              fontSize: 13,
                              fontWeight: FontWeight.w200))
                    ],
                  ),
                )
              ],
            ),
            CustomButton(
                showInk: false,
                padding: const EdgeInsets.all(0),
                onTap: () {
                  if (this.isFavorite == CharacterFavoriteType.favorite) {
                    characterStore.removeCharacterFavorites(character);
                  } else {
                    characterStore.addCharacterFavorites(character);
                  }
                },
                child: this.isFavorite == CharacterFavoriteType.favorite
                    ? const Icon(
                        Icons.favorite_rounded,
                        color: Colors.redAccent,
                        size: 25,
                      )
                    : const Icon(
                        Icons.favorite_rounded,
                        color: AppColors.Colors.gray,
                        size: 25,
                      ))
          ],
        ));
  }
}
