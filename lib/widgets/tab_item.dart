import 'package:flutter/material.dart';

class TabItem {
  final Tab tab;
  final String title;
  final Widget screen;

  TabItem({required this.tab, required this.screen, this.title = ""});
}
