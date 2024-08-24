import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class CustomTextInput extends StatelessWidget {
  final TextEditingController controller;
  final int? maxLines;
  final String hint;
  final TextInputType? inputType;
  final bool? obscureText;
  final bool? enableSuggestions;
  final int? maxLength;
  final void  Function(String?)? onChanged;
  final FormFieldValidator? validator;
  final bool? required;

  const CustomTextInput(
      {Key? key,
      required this.controller,
      this.maxLines,
      this.enableSuggestions,
      required this.hint,
      this.validator,
      this.maxLength,
      this.inputType,
      this.obscureText, this.required, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enableSuggestions: enableSuggestions ?? false,
      maxLines: maxLines ?? 1,
      maxLength: maxLength,
      onChanged: onChanged,
      keyboardType: inputType ?? TextInputType.text,
      decoration: InputDecoration(
          label: Text.rich(TextSpan(children: <InlineSpan>[
            WidgetSpan(child: Text(hint)),
            if(required == true)
              const WidgetSpan(child: Text(' *',style: TextStyle(color: Colors.red),)),


          ])),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: ColorTheme.secondaryColor, // Simple color for testing
              width: 2.0, // Thinner width
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.blueAccent, // Different color for focused state
              width: 2.0,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: ColorTheme.secondaryColor,
              style: BorderStyle.solid,
              width: 10.0,
            ),
          )),
      obscureText: obscureText ?? false,
      validator: validator,
    );
  }
}
