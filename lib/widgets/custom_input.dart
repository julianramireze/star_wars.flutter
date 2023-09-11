import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:star_wars/utils/helpers/hooks.dart';
import 'package:star_wars/widgets/custom_boxhsadow.dart';

class CustomInput extends HookWidget {
  final key;
  final String initialValue;
  final hint;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final buttonColor;
  final textColor;
  final onChange;
  final int? maxLength;
  final bool showMaxLength;
  final bool isPassword;
  final TextAlign textAlign;
  final TextAlignVertical textAlignVertical;
  final String? Function(String?)? validator;
  final int lines;
  final enabled;
  final clear;
  final Icon? prefixIcon;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  List<TextInputFormatter>? inputFormatters;
  final BorderRadius? borderRadius;
  final Color? colorBackground;
  final EdgeInsets contentPadding;
  final bool hideErrorOnFalse;
  final Color? colorShadow;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function()? onEditingComplete;
  final Color? colorEye;
  final double? height;

  var _controller = useTextEditingController(text: "");

  CustomInput(
      {this.key,
      this.initialValue = "",
      this.hint = "Example",
      this.hintStyle,
      this.buttonColor,
      this.textColor,
      this.onChange,
      this.maxLength,
      this.validator,
      this.isPassword = false,
      this.textAlign = TextAlign.start,
      this.textAlignVertical = TextAlignVertical.top,
      this.lines = 1,
      this.showMaxLength = false,
      this.enabled = true,
      this.clear = false,
      this.prefixIcon,
      this.textInputType,
      this.textInputAction,
      this.inputFormatters,
      this.borderRadius,
      this.colorBackground,
      this.contentPadding =
          const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
      this.hideErrorOnFalse = false,
      this.colorShadow,
      this.style,
      this.controller,
      this.focusNode,
      this.onEditingComplete,
      this.colorEye,
      this.height});

  @override
  Widget build(BuildContext context) {
    var errorMessage = useState("");
    var passwordVisible = useState(false);

    useAsyncEffect(() {
      _controller.text = initialValue;
      _controller.addListener(() {
        if (onChange != null) onChange(_controller.text);
      });
    }, () => {}, []);

    useAsyncEffect(() {
      if (clear) {
        _controller.text = "";
      }
    }, () => {}, [clear]);

    var buildContentPadding = isPassword
        ? EdgeInsets.only(top: 10, bottom: 10, right: 45, left: 10)
        : contentPadding;

    return Column(
      children: [
        CustomBoxShadow(
          colorShadow: colorShadow,
          borderRadius: borderRadius,
          colorBackground: colorBackground,
          child: Stack(alignment: Alignment.centerRight, children: <Widget>[
            Positioned(left: 10, child: prefixIcon ?? Container()),
            Container(
              padding: prefixIcon != null
                  ? EdgeInsets.only(left: 35)
                  : EdgeInsets.all(0),
              height: height ?? 50,
              child: TextFormField(
                key: key,
                focusNode: focusNode,
                inputFormatters: inputFormatters,
                controller: controller ?? _controller,
                enabled: enabled,
                textAlign: textAlign,
                textAlignVertical: textAlignVertical,
                maxLength: maxLength ?? 255,
                maxLines: 1,
                decoration: InputDecoration(
                    hintText: this.hint,
                    hintStyle: this.hintStyle,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    errorStyle: TextStyle(height: 0),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabled: enabled,
                    isDense: true,
                    contentPadding: buildContentPadding,
                    counterText: ""),
                style: style ??
                    TextStyle(
                        fontSize: 15,
                        color: enabled ? this.textColor : Colors.grey),
                cursorColor: this.textColor,
                textInputAction: textInputAction ?? TextInputAction.done,
                keyboardType: textInputType ?? TextInputType.name,
                obscureText: isPassword ? !passwordVisible.value : false,
                onChanged: (value) {
                  errorMessage.value = "";
                  if (onChange != null) onChange(value);
                },
                onEditingComplete: onEditingComplete,
                validator: (value) {
                  if (validator != null) {
                    var validate = validator!(value ?? "");
                    errorMessage.value = validate ?? "";
                    return validate != null ? '' : null;
                  }
                  return null;
                },
              ),
            ),
            if (isPassword)
              GestureDetector(
                child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(
                      !passwordVisible.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: colorEye ?? Colors.grey,
                    )),
                onTap: () {
                  passwordVisible.value = !passwordVisible.value;
                },
              ),
          ]),
        ),
        if (!hideErrorOnFalse)
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              margin: EdgeInsets.only(
                  top: errorMessage.value.length > 0 ? 2.5 : 5,
                  bottom: errorMessage.value.length > 0 ? 2.5 : 0),
              child: Text(
                errorMessage.value.length > 0 ? errorMessage.value : '',
                style: TextStyle(
                    color: errorMessage.value.length > 0
                        ? Colors.redAccent
                        : Colors.transparent,
                    fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ])
      ],
    );
  }
}
