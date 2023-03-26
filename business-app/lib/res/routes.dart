// ignore_for_file: prefer_const_constructors, unused_element, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:paynless/screens/client_forms/client_form_phone.dart';
import 'package:paynless/screens/client_forms/client_form_shop_details.dart';
import 'package:paynless/screens/dashboard/DashboardPage.dart';
import 'package:paynless/screens/auth/AuthPage.dart';
import 'package:paynless/screens/welcome/welcome.dart';

import '../screens/splash/Splash.dart';

class MyRoute {
  static const String splashScreen = '/splash';
  static const String welcome = "/welcome";
  static const String clientFormPhone = '/clientFormPhone';
  static const String clientFormShopDetails = '/clientFormShopDetails';
  static const String dashboard = '/home';
  static const String loginPage = '/auth';
}

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case MyRoute.splashScreen:
        return MaterialPageRoute(builder: (_) => const Splash());
      case MyRoute.welcome:
        return MaterialPageRoute(builder: (_) => const Welcome());
      case MyRoute.loginPage:
        return MaterialPageRoute(builder: (_) => const AuthPage());
      case MyRoute.clientFormPhone:
        return MaterialPageRoute(builder: (_) => const ClientFormPhone());
      case MyRoute.clientFormShopDetails:
        return MaterialPageRoute(builder: (_) => const ClientFormShopDetails());
      case MyRoute.dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardPage());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('404'),
        ),
        body: const Center(
          child: Text('ERROR 404'),
        ),
      );
    });
  }
}
