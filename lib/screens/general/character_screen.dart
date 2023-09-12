import 'package:easy_localization/easy_localization.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:star_wars/constants/routes.dart';
import 'package:star_wars/models/character.dart';
import 'package:star_wars/config/router.dart' as AppRouter;
import 'package:star_wars/widgets/custom_boxhsadow.dart';
import 'package:star_wars/widgets/custom_button.dart';
import 'package:star_wars/constants/colors.dart' as AppColors;

class CharacterScreen extends HookWidget {
  final CharacterModel character;

  const CharacterScreen({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      AppRouter.Router.popRoute(context);
      return false;
    }

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
                                colorBackground: Colors.white.withOpacity(0.2),
                                colorShadow: Colors.transparent,
                                child: CustomButton(
                                    onTap: () {
                                      AppRouter.Router.fluroRouter.navigateTo(
                                          context, Routes.settings.toString(),
                                          transition: TransitionType.fadeIn);
                                    },
                                    borderRadius: BorderRadius.circular(100),
                                    padding: const EdgeInsets.all(0),
                                    child: const Icon(
                                      Icons.settings_rounded,
                                      color: AppColors.Colors.blue,
                                      size: 25,
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                ))));
  }
}
