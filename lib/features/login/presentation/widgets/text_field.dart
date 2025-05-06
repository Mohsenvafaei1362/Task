import 'package:flutter/material.dart';
import 'package:testproject/core/extentions/extention.dart';
import 'package:testproject/core/utils/colors.dart';

// ignore: must_be_immutable
class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    this.labelText,
    this.hintText,
    this.width,
    this.height,
    this.onChanged,
    this.fillColor,
  });
  final double? width;
  final double? height;
  final String? hintText;
  final String? labelText;
  final void Function(String)? onChanged;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? context.screenwidth * 0.8,
      height: height ?? 50,
      child: TextField(
        style: TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        onChanged: onChanged,
        decoration: InputDecoration(
          fillColor: fillColor ?? Colors.transparent,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.withAlpha(100)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: UNITED_NATIONS_BLUE_COLOR.withAlpha(700),
              width: 2,
            ),
          ),
          labelText: labelText ?? 'Username',
          labelStyle: TextStyle(
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
