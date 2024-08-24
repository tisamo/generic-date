import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generic_date/shared/styles/colors.dart';
import '../elements/bottom-nav.dart';

class SimpleLayout extends StatelessWidget {
  final Widget layout;
  final String title;
  final bool hideAppbar;
  final bool showNavbar;

  const SimpleLayout(
      {Key? key, required this.layout, required this.title, this.hideAppbar = false, this.showNavbar = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: hideAppbar ? null :
          AppBar(
              title: Text(title),
              backgroundColor: ColorTheme.secondaryColor,
              titleTextStyle: const TextStyle(color: Colors.white)),
      bottomNavigationBar: showNavbar ? const BottomNav(): null,
      body: layout,
    );
  }
}

