import 'package:flutter/material.dart';

class NavigationText extends StatelessWidget {
  final String text;
  final String route;
 final double padding;


  NavigationText({required this.text, required this.route,  this.padding = 10});

  @override
  Widget build(BuildContext context) {
    return  Padding(padding: EdgeInsets.only(top: padding),
      child: TextButton(
        child: Text(text),
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }
}