import 'package:star_wars/constans/colors.dart' as AppColors;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const ColorScheme colorSchemeDark = ColorScheme(
  onPrimary: AppColors.Colors.blue,
  primary: AppColors.Colors.blue,
  primaryContainer: AppColors.Colors.blueLight,
  onSecondary: AppColors.Colors.steelBlue,
  secondary: AppColors.Colors.steelBlue,
  secondaryContainer: AppColors.Colors.steelBlueLight,
  onBackground: AppColors.Colors.white,
  onError: Colors.redAccent,
  error: Colors.redAccent,
  onSurface: AppColors.Colors.black,
  surface: AppColors.Colors.black,
  background: AppColors.Colors.black,
  brightness: Brightness.dark,
);

var themeLight = ThemeData(
    fontFamily: GoogleFonts.roboto().fontFamily, colorScheme: colorSchemeDark);
