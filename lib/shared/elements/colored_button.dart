import 'package:flutter/material.dart';
import 'package:generic_date/shared/styles/colors.dart';

import '../styles/button_style.dart';
import '../styles/text_styles.dart';


class ColoredButton extends StatelessWidget {
  final Color color;
  final String label;
  final VoidCallback buttonFunction;
  const ColoredButton({
    super.key,
    required this.color,
    required this.buttonFunction,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: buttonFunction,
      style: ThemeButton.basicButton(color: ColorTheme.secondaryColor),
      child:  Padding(
        padding: EdgeInsets.only(top:5),
        child: Text('Finalize',
          style: ThemeText.textButtonStyle(color: Colors.white),
          textAlign: TextAlign.center,),
      ),
    );
  }
}
