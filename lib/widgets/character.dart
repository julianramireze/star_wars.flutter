import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:star_wars/models/character.dart';
import 'package:star_wars/stores/character.dart';
import 'package:star_wars/widgets/custom_button.dart';
import 'package:star_wars/constants/colors.dart' as AppColors;

enum CharacterFavoriteType { favorite, unfavorite, none }

enum CharacterReportType { report, unreported, none }

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

    return CustomButton(
        borderRadius: BorderRadius.circular(5),
        onTap: () {},
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
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
                  child: Text(character.name,
                      maxLines: 1,
                      style: TextStyle(
                          color: AppColors.Colors.blue,
                          fontSize: 15,
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ),
            Row(
              children: [
                CustomButton(
                    showInk: false,
                    padding: EdgeInsets.all(0),
                    onTap: () {
                      if (this.isFavorite == CharacterFavoriteType.favorite) {
                        characterStore.removeCharacterFavorites(character);
                      } else {
                        characterStore.addCharacterFavorites(character);
                      }
                    },
                    child: this.isFavorite == CharacterFavoriteType.favorite
                        ? Icon(
                            Icons.favorite_rounded,
                            color: Colors.redAccent,
                            size: 25,
                          )
                        : Icon(
                            Icons.favorite_rounded,
                            color: AppColors.Colors.gray,
                            size: 25,
                          ))
              ],
            )
          ],
        ));
  }
}
