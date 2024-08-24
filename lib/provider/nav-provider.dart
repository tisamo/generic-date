import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/tabs/home.dart';

class NavProvider extends ChangeNotifier {
  int selectedIndex = 0;

  void setNavIndex(indexToNavigate, context) {
    if (indexToNavigate == selectedIndex) return;
    selectedIndex = indexToNavigate;
    notifyListeners();

    switch (indexToNavigate) {
      case 0:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
              (Route<dynamic> route) => false,
        );        break;
      case 1:
        Navigator.pushNamed(context, '/messages');
            break;
      case 2:
        Navigator.pushNamed(context, '/profile');
        break;
      case 3:
        Navigator.pushNamed(context, '/profile');
        break;
    }

  }
}
