import 'package:flutter/material.dart';
import 'package:generic_date/shared/styles/colors.dart';

abstract class ThemeButton {
  static  ButtonStyle basicButton({Color? color}) {
    return  ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(color ?? ColorTheme.secondaryColor),
      textStyle: WidgetStateProperty.all<TextStyle>(
        const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 14,
        ),
      ),
      minimumSize: WidgetStateProperty.all<Size>(const Size(200, 50)),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side:  BorderSide(
                color: color ?? ColorTheme.secondaryColor,
                width: 2.0),
          )
      ),
      foregroundColor:
      WidgetStateProperty.all<Color>(Colors.white),
    );
  }
}
