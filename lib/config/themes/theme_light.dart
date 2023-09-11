import 'package:star_wars/constants/colors.dart' as AppColors;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const ColorScheme colorSchemeDark = ColorScheme(
  primary: AppColors.Colors.blue,
  onPrimary: AppColors.Colors.blueLight,
  inversePrimary: AppColors.Colors.blueDark,
  secondary: AppColors.Colors.steelBlue,
  onSecondary: AppColors.Colors.steelBlueLight,
  surface: AppColors.Colors.blue,
  onSurface: AppColors.Colors.black,
  background: AppColors.Colors.white,
  onBackground: AppColors.Colors.gray,
  error: Colors.redAccent,
  onError: Colors.redAccent,
  brightness: Brightness.light,
);

var themeLight = ThemeData(
    fontFamily: GoogleFonts.roboto().fontFamily, colorScheme: colorSchemeDark);
