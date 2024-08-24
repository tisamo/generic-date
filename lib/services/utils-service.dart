

import 'package:flutter/material.dart';
import 'package:generic_date/services/navigator-service.dart';

void showToast(String message){
  BuildContext? context = NavigationService.navigatorKey.currentState?.context;
  if(context== null){
    return;
  }
  ScaffoldMessenger.of(context)
      .showSnackBar(
     SnackBar(
        content: Text(message)),
  );
}

int calculateAge(DateTime birthDate) {
  DateTime today = DateTime.now();
  int age = today.year - birthDate.year;

  if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
    age--;
  }

  return age;
}