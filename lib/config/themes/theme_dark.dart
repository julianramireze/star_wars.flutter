import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:star_wars/constants/colors.dart' as AppColors;

const ColorScheme colorSchemeDark = ColorScheme(
  primary: AppColors.Colors.blue,
  onPrimary: AppColors.Colors.blueLight,
  inversePrimary: AppColors.Colors.blueDark,
  secondary: AppColors.Colors.steelBlue,
  onSecondary: AppColors.Colors.steelBlueLight,
  surface: AppColors.Colors.blue,
  onSurface: AppColors.Colors.white,
  background: AppColors.Colors.black,
  onBackground: AppColors.Colors.gray,
  error: Colors.redAccent,
  onError: Colors.redAccent,
  brightness: Brightness.light,
);

var themeDark = ThemeData(
    fontFamily: GoogleFonts.roboto().fontFamily, colorScheme: colorSchemeDark);
