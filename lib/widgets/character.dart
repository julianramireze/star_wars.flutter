import 'package:easy_localization/easy_localization.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:star_wars/constants/prompts.dart';
import 'package:star_wars/constants/routes.dart';
import 'package:star_wars/models/character.dart';
import 'package:star_wars/stores/character.dart';
import 'package:star_wars/stores/planet.dart';
import 'package:star_wars/stores/settings.dart';
import 'package:star_wars/utils/helpers/hooks.dart';
import 'package:star_wars/utils/helpers/regex.dart';
import 'package:star_wars/widgets/custom_button.dart';
import 'package:star_wars/constants/colors.dart' as AppColors;
import 'package:star_wars/config/router.dart' as AppRouter;
import 'package:star_wars/widgets/stability_ai_image.dart';

enum CharacterFavoriteType { favorite, unfavorite, none }

enum CharacterReportType { report, unreported, none }

enum GenderType { male, female, hermaphrodite, unknown }

class Gender {
  final String gender;
  final Color color;
  final IconData icon;

  Gender({required this.gender, required this.color, required this.icon});

  static Gender StringToGender(String gender, bool darkMode) {
    late Gender finalGender;

    if (gender == GenderType.male.name) {
      finalGender = Gender(
          gender: GenderType.male.name,
          color: darkMode ? Colors.greenAccent : Colors.green[400]!,
          icon: Icons.man_rounded);
    } else if (gender == GenderType.female.name) {
      finalGender = Gender(
          gender: GenderType.female.name,
          color: darkMode ? Colors.pinkAccent : Colors.pink[400]!,
          icon: Icons.girl_rounded);
    } else if (gender == GenderType.hermaphrodite.name) {
      finalGender = Gender(
          gender: GenderType.hermaphrodite.name,
          color: darkMode ? Colors.purpleAccent : Colors.purple[400]!,
          icon: Icons.transgender_rounded);
    } else {
      finalGender = Gender(
          gender: GenderType.unknown.name,
          color: darkMode ? Colors.orangeAccent : Colors.orange[400]!,
          icon: Icons.remove_rounded);
    }

    return finalGender;
  }
}

class Character extends HookWidget {
  final CharacterModel character;
  final CharacterFavoriteType isFavorite;
  final CharacterReportType isReported;
  final Function? onTap;

  const Character(
      {Key? key,
      required this.character,
      required this.isFavorite,
      required this.isReported,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMounted = useIsMounted();
    final planetStore = Provider.of<PlanetStore>(context);
    final settingsStore = Provider.of<SettingsStore>(context);
    final characterStore = Provider.of<CharacterStore>(context);

    final planet = useState({});
    Gender gender =
        Gender.StringToGender(character.gender, settingsStore.darkMode);

    useAsyncEffect(() {
      final homeWorldID = Regex.getID(character.homeWorld);
      if (homeWorldID != null) planetStore.getByID(homeWorldID);
    }, () {}, []);

    useAsyncEffect(() {
      if (planetStore.planets.isNotEmpty && isMounted()) {
        planet.value = planetStore.planets
            .firstWhere((planet) =>
                Regex.getID(planet.url) == Regex.getID(character.homeWorld))
            .toJson();
      }

      planetStore.requestStateGetByID.clear();
    }, () {}, [planetStore.requestStateGetByID.success]);

    return CustomButton(
        borderRadius: BorderRadius.circular(5),
        onTap: () {
          if (onTap != null) {
            onTap!();
          }
        },
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                    width: 60,
                    height: 60,
                    child: StabilityAiImage(
                      prompt: planet.value.keys.isNotEmpty
                          ? Prompts.character(
                              character.name, planet.value['terrain'])
                          : '',
                      name: character.name,
                      isCircle: true,
                      loadingColors: [
                        AppColors.Colors.gray,
                        AppColors.Colors.grayDark
                      ],
                    )),
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
                              fontWeight: FontWeight.w400))
                    ],
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.directions_car_rounded,
                        color: Theme.of(context).colorScheme.onSurface,
                        size: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 1),
                        child: Text(character.vehicles.length.toString(),
                            maxLines: 1,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 14,
                                fontWeight: FontWeight.normal)),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.rocket_rounded,
                        color: Theme.of(context).colorScheme.onSurface,
                        size: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 1),
                        child: Text(character.starShips.length.toString(),
                            maxLines: 1,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 14,
                                fontWeight: FontWeight.normal)),
                      ),
                    ],
                  ),
                ),
                if (isReported != CharacterReportType.none)
                  CustomButton(
                      enabled: settingsStore.connectionEnabled,
                      showInk: false,
                      padding: const EdgeInsets.all(0),
                      onTap: () {
                        if (isReported == CharacterReportType.report) {
                          characterStore.removeCharacterReported(character);
                        } else {
                          characterStore.addCharacterReported(character);
                        }
                      },
                      child: isReported == CharacterReportType.report &&
                              settingsStore.connectionEnabled
                          ? const Icon(
                              Icons.report_problem_rounded,
                              color: Colors.orangeAccent,
                              size: 25,
                            )
                          : const Icon(
                              Icons.report_problem_rounded,
                              color: AppColors.Colors.gray,
                              size: 25,
                            )),
                if (isFavorite != CharacterFavoriteType.none)
                  CustomButton(
                      showInk: false,
                      padding: const EdgeInsets.all(0),
                      onTap: () {
                        if (isFavorite == CharacterFavoriteType.favorite) {
                          characterStore.removeCharacterFavorite(character);
                        } else {
                          characterStore.addCharacterFavorite(character);
                        }
                      },
                      child: isFavorite == CharacterFavoriteType.favorite
                          ? const Icon(
                              Icons.favorite_rounded,
                              color: Colors.redAccent,
                              size: 25,
                            )
                          : const Icon(
                              Icons.favorite_rounded,
                              color: AppColors.Colors.gray,
                              size: 25,
                            )),
              ],
            ),
          ],
        ));
  }
}
