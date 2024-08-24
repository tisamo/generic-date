
import 'package:flutter/material.dart';
import 'package:generic_date/shared/styles/colors.dart';

import 'package:flutter/material.dart';

abstract class ThemeText {
  static TextStyle textButtonStyle({Color? color, double? fontSize, FontWeight? fontWeight}) {
    return TextStyle(
      fontSize: fontSize ?? 20,
      height: 0.5,
      color: color ?? Colors.black,
      fontWeight: fontWeight ?? FontWeight.w600,
    );
  }
}
