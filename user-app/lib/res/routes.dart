// ignore_for_file: prefer_const_constructors, unused_element, non_constant_identifier_names, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:paynless/screens/auth/welcome.dart';
import 'package:paynless/screens/dashboard/DashboardPage.dart';
import 'package:paynless/screens/auth/AuthPage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:paynless/screens/payment/payment.dart';
import 'package:paynless/screens/successful/successful.dart';
import 'package:permission_handler/permission_handler.dart';

import '../screens/dashboard/dashboard_expanded.dart';
import '../screens/splash/Splash.dart';

class MyRoute {
  static const String splashScreen = '/splash';
  static const String welcomePage = '/welcome';
  static const String dashboard = '/home';
  static const String loginPage = '/auth';
  static const String payReq = '/payreq';
  static const String nearby = '/nearby';
  static const String distance = '/distance';
  static const String profile = '/profile';
  static const String mapDetails = '/map-details';
  static const String permissionGranted = '/permission-granted';
  static const String payment = '/payment';
  static const String paymentConf = '/payment-conf';
}

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case MyRoute.splashScreen:
        return PageTransition(
            child: Splash(), settings: settings, type: PageTransitionType.fade);
      case MyRoute.welcomePage:
        return PageTransition(
            child: WelcomePage(),
            settings: settings,
            type: PageTransitionType.fade);
      case MyRoute.loginPage:
        return PageTransition(
            child: AuthPage(),
            settings: settings,
            type: PageTransitionType.fade);
      case MyRoute.dashboard:
        return PageTransition(
            child: DashboardPage(),
            settings: settings,
            type: PageTransitionType.fade);

      case MyRoute.profile:
        return PageTransition(
            child: DashboardPage(),
            settings: settings,
            type: PageTransitionType.fade);
      case MyRoute.payReq:
        if (args is bool) {
          return PageTransition(
              child: DashboardExpanded(
                isExpanded: args,
              ),
              settings: settings,
              type: PageTransitionType.fade);
        } else {
          return PageTransition(
              child: DashboardExpanded(
                isExpanded: false,
              ),
              settings: settings,
              type: PageTransitionType.fade);
        }

      case MyRoute.nearby:
        if (args is bool) {
          return PageTransition(
              child: DashboardExpanded(
                isExpanded: args,
              ),
              settings: settings,
              type: PageTransitionType.fade);
        } else {
          return PageTransition(
              child: DashboardExpanded(
                isExpanded: false,
              ),
              settings: settings,
              type: PageTransitionType.fade);
        }
      case MyRoute.permissionGranted:
        if (args is bool) {
          return PageTransition(
              child: DashboardExpanded(
                isExpanded: args,
              ),
              settings: settings,
              type: PageTransitionType.fade);
        } else {
          return PageTransition(
              child: DashboardExpanded(
                isExpanded: false,
              ),
              settings: settings,
              type: PageTransitionType.fade);
        }
      case MyRoute.distance:
        if (args is bool) {
          return PageTransition(
              child: DashboardExpanded(
                isExpanded: args,
              ),
              settings: settings,
              type: PageTransitionType.fade);
        } else {
          return PageTransition(
              child: DashboardExpanded(
                isExpanded: false,
              ),
              settings: settings,
              type: PageTransitionType.fade);
        }

      case MyRoute.mapDetails:
        if (args is bool) {
          return PageTransition(
              child: DashboardExpanded(
                isExpanded: args,
              ),
              settings: settings,
              type: PageTransitionType.fade);
        } else {
          return PageTransition(
              child: DashboardExpanded(
                isExpanded: false,
              ),
              settings: settings,
              type: PageTransitionType.fade);
        }
      case MyRoute.payment:
        return PageTransition(
            child: Payment(),
            settings: settings,
            type: PageTransitionType.fade);
      case MyRoute.paymentConf:
        return PageTransition(
            child: Successful(),
            settings: settings,
            type: PageTransitionType.fade);
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
