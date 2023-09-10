import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:star_wars/constants/colors.dart' as AppColors;

const ColorScheme colorSchemeDark = ColorScheme(
  onPrimary: AppColors.Colors.blue,
  primary: AppColors.Colors.blue,
  primaryContainer: AppColors.Colors.blueLight,
  onSecondary: AppColors.Colors.steelBlue,
  secondary: AppColors.Colors.steelBlue,
  secondaryContainer: AppColors.Colors.steelBlueLight,
  onBackground: AppColors.Colors.black,
  onError: Colors.redAccent,
  error: Colors.redAccent,
  onSurface: AppColors.Colors.black,
  surface: AppColors.Colors.black,
  background: AppColors.Colors.black,
  brightness: Brightness.dark,
);

var themeDark = ThemeData(
    fontFamily: GoogleFonts.roboto().fontFamily, colorScheme: colorSchemeDark);
