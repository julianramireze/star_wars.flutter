import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomButton extends HookWidget {
  final onTap;
  final BorderRadius? borderRadius;
  final child;
  final Color? color;
  final Color? disabledColor;
  final loading;
  final success;
  final enabled;
  final padding;
  final centerText;
  final margin;
  final showInk;
  final Color? loadingColor;

  const CustomButton(
      {super.key,
      this.onTap,
      this.borderRadius,
      this.child,
      this.color,
      this.disabledColor,
      this.loading = false,
      this.success,
      this.enabled = true,
      this.padding,
      this.centerText = false,
      this.margin,
      this.showInk = true,
      this.loadingColor});

  toucher({child, ink}) {
    if (ink) {
      return InkWell(
          focusColor: Colors.transparent,
          borderRadius: borderRadius ?? BorderRadius.circular(0),
          onTap: () {
            if (onTap != null) onTap();
          },
          child: child);
    }
    return GestureDetector(
        onTap: () {
          if (onTap != null) onTap();
        },
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
        ignoring: !enabled,
        child: Material(
            borderRadius: borderRadius ?? BorderRadius.circular(0),
            color: enabled
                ? color ?? Colors.transparent
                : disabledColor ?? Colors.transparent,
            child: toucher(
                child: Container(
                  margin: margin,
                  padding:
                      padding ?? const EdgeInsets.only(left: 10, right: 10),
                  child: Stack(
                    children: [
                      Container(child: child ?? Container()),
                      if (loading)
                        Positioned.fill(
                            right: 10,
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                  width: 15,
                                  height: 15,
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        loadingColor ?? Colors.white),
                                  )),
                                ))),
                      if (success != null && success.runtimeType == bool)
                        success == true
                            ? const Positioned.fill(
                                right: 10,
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Icon(
                                        Icons.check_outlined,
                                        color: Colors.white,
                                      ),
                                    )))
                            : const Positioned.fill(
                                right: 10,
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Icon(
                                        Icons.close_outlined,
                                        color: Colors.white,
                                      ),
                                    )))
                    ],
                  ),
                ),
                ink: showInk)));
  }
}
