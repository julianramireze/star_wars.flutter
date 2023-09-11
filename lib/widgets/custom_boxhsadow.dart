import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomBoxShadow extends HookWidget {
  final child;
  final double? radius;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? blurRadius;
  final double? spreadRadius;
  final BoxDecoration? decoration;
  final Color? colorShadow;
  final Color? colorBackground;
  final double borderWidth;
  final Color borderColor;

  CustomBoxShadow(
      {this.child,
      this.radius,
      this.borderRadius,
      this.width,
      this.height,
      this.margin,
      this.padding,
      this.decoration,
      this.blurRadius,
      this.spreadRadius,
      this.colorShadow,
      this.colorBackground,
      this.borderWidth = 0.0,
      this.borderColor = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: decoration ??
            BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: blurRadius ?? 2,
                  spreadRadius: spreadRadius ?? 0,
                  color: this.colorShadow ?? Colors.grey.withOpacity(0.5),
                ),
              ],
              color: this.colorBackground ?? Colors.white,
              borderRadius: borderRadius ??
                  BorderRadius.all(Radius.circular(this.radius ?? 10.0)),
              border: Border.all(color: borderColor, width: borderWidth),
            ),
        width: width,
        height: height,
        margin: margin,
        padding: padding ?? EdgeInsets.all(0),
        child: child);
  }
}
