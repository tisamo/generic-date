

import 'package:flutter/material.dart';
import 'package:generic_date/provider/nav-provider.dart';
import 'package:generic_date/screens/Profile/UserSettings.dart';
import 'package:generic_date/screens/authentication/login.dart';
import 'package:generic_date/screens/tabs/swiper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'provider/userlist-provider.dart';
import 'screens/screens.dart';

Future<void> main() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  if(token != null) {
    var userProvider = UserProvider();
    var user = await userProvider.authenticate(token);
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserProvider()),
          ChangeNotifierProvider(create: (context) => NavProvider())
        ],
        child: MaterialApp(routes: {
          '/': (context) =>  const Home(),
          '/home': (context) => const Home(),
          '/swiper': (context) => const Swiper(),
          '/profile': (context) => const Swiper(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/events/new': (context) => const AddEventScreen()
        }));
  }
}
