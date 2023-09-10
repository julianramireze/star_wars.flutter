// ignore_for_file: prefer_function_declarations_over_variables

import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:star_wars/config/api.dart';
import 'package:star_wars/constans/assets.dart';
import 'package:star_wars/constans/colors.dart' as AppColors;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:lottie/lottie.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

var closeAppModal = (context, onPressCancel, onPressAccept) {
  return Alert(
      context: context,
      image: const Icon(Icons.sentiment_dissatisfied_outlined,
          color: Colors.redAccent, size: 45),
      title: tr("close_app"),
      desc: tr("want_close_app"),
      style: AlertStyle(
        isCloseButton: false,
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(
            color: AppColors.Colors.black,
          ),
        ),
        backgroundColor: AppColors.Colors.black,
        titleStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        descStyle: const TextStyle(fontSize: 14, color: Colors.white),
      ),
      buttons: [
        DialogButton(
          color: Colors.blue,
          height: 35,
          child: Text(
            tr('cancel'),
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
          onPressed: () => onPressCancel(),
        ),
        DialogButton(
          color: AppColors.Colors.blue,
          height: 35,
          child: Text(
            tr('accept'),
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
          onPressed: () => onPressAccept(),
        ),
      ]);
};
