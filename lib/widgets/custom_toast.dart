import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToast {
  final BuildContext context;
  final Icon? icon;
  final String? text;
  final Color? textColor;
  final TextStyle? textStyle;
  final Color backgroundColor;
  final Duration fadeDuration;
  final double top;
  final double bottom;
  final double left;
  final double right;

  CustomToast(this.context,
      {this.icon,
      this.text,
      this.textColor,
      this.textStyle,
      this.backgroundColor = Colors.grey,
      this.fadeDuration = const Duration(milliseconds: 350),
      this.top = 0,
      this.bottom = -1,
      this.left = 0,
      this.right = 0});

  show() {
    FToast().init(context).showToast(
        fadeDuration: fadeDuration,
        positionedToastBuilder: (context, child) {
          return Positioned(
            top: top,
            left: left,
            right: right,
            bottom: bottom == -1
                ? MediaQuery.of(context).size.height * 0.03
                : bottom,
            child: child,
          );
        },
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.10),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: backgroundColor,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon ?? Container(),
              SizedBox(
                width: 12.0,
              ),
              Flexible(
                child: Text(text ?? "",
                    style: textStyle ??
                        TextStyle(color: textColor ?? Colors.white)),
              ),
            ],
          ),
        ));
  }
}
