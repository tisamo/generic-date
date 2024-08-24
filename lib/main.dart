

import 'package:flutter/material.dart';
import 'package:generic_date/models/message.dart';
import 'package:generic_date/provider/nav-provider.dart';
import 'package:generic_date/screens/Profile/Infp.dart';
import 'package:generic_date/screens/Profile/infp-result.dart';
import 'package:generic_date/screens/Profile/profile-settings.dart';
import 'package:generic_date/screens/authentication/login.dart';
import 'package:generic_date/screens/authentication/namedate.dart';
import 'package:generic_date/screens/authentication/verification.dart';
import 'package:generic_date/screens/screens.dart';
import 'package:generic_date/screens/tabs/home.dart';
import 'package:generic_date/services/navigator-service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'provider/userlist-provider.dart';



void main()  {
  runApp(MyApp());
}

class MyApp extends StatelessWidget with RouteAware {
  MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final NavigatorObserver routeObserver = RouteObserverExample();

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserProvider()),
          ChangeNotifierProvider(create: (context) => NavProvider())
        ],
        child:  MaterialApp(
          navigatorKey: NavigationService.navigatorKey,
          onGenerateRoute: RouteGenerator.generateRoute,
          navigatorObservers: [routeObserver],
        ));
  }
}
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Uri uri = Uri.parse(settings.name ?? '');

    final Map<String, WidgetBuilder> routes = {
      '/': (_) =>  const Home(),
      '/register': (_) => const RegisterScreen(),
      '/login': (_) => const LoginScreen(),
      '/verification': (_) => const VerificationScreen(),
      '/messages': (_) => const Messages(),
      '/profile': (_) => const Profile(),
      '/profile-settings': (_) => const  ProfileSettings(),
      '/personality-test': (_) => QuizScreen(),
    };

    // Handle named routes
    if (routes.containsKey(uri.path)) {
      return MaterialPageRoute(
        builder: routes[uri.path]!,
        settings: settings,
      );
    }

    // Handle dynamic routes
    if (uri.pathSegments.length == 2 && uri.pathSegments.first == 'test-result') {
      final type = uri.pathSegments[1];
      return MaterialPageRoute(
        builder: (_) => InfpResultScreen(infpType: type),
        settings: settings,
      );
    }

    // Handle unknown routes
    return _errorRoute();
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Page not found')),
      ),
    );
  }
}





class RouteObserverExample extends NavigatorObserver {


  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    final BuildContext? context = NavigationService.navigatorKey.currentContext;
    if (context != null) {
      try {
        final navProvider = Provider.of<NavProvider>(context, listen: false);
        int selectedRouteIndex = 0;
        switch (previousRoute?.settings.name) {
          case '/':
            selectedRouteIndex = 0;
            break;
          case '/profile':
            selectedRouteIndex = 3;
            break;
          default:
            selectedRouteIndex = 2;
            break;
        }
        navProvider.setNavIndex(selectedRouteIndex, context);
      } catch (e) {
        // Handle any exceptions or errors that might occur
      }
    }
  }
}