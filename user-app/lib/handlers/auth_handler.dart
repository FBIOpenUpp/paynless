// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../api/auth_services.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../res/routes.dart';
import '../res/toast.dart';

class AuthHandler {
  _getInitialRoute(BuildContext context) async {
    final auth_service = AuthApi();
    final String? authTOken = await _getToken();
    log(authTOken.toString());
    if (authTOken != null) {
      final User? user = await auth_service.getUserData(token: authTOken);

      if (user != null) {
        // var body = json.decode(authTOken);
        Provider.of<UserProvider>(context, listen: false).setUser(user);
        if (await Permission.location.status != PermissionStatus.granted) {
          Timer(
              const Duration(seconds: 2),
              () => Navigator.of(context).pushNamedAndRemoveUntil(
                  MyRoute.permissionGranted, (Route<dynamic> route) => false));
        } else {
          Timer(
              const Duration(seconds: 2),
              () => Navigator.of(context).pushNamedAndRemoveUntil(
                  MyRoute.dashboard, (Route<dynamic> route) => false));
        }
      } else {
        Timer(
            const Duration(seconds: 2),
            () =>
                Navigator.of(context).pushReplacementNamed(MyRoute.loginPage));
      }
    } else {
      showToast('Please Login');
      Timer(
          const Duration(seconds: 2),
          () => Navigator.of(context).pushNamedAndRemoveUntil(
              MyRoute.welcomePage, (Route<dynamic> route) => false));
    }
  }

  void _deleteToken(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    prefs.remove("fcmToken");
    prefs.remove('refreshToken');
    prefs.remove('userId');

    showToast('Logout Successful');
    Navigator.of(context).pushNamedAndRemoveUntil(
        MyRoute.loginPage, (Route<dynamic> route) => false);
  }

  void _saveToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('token', token);
  }

  void _saveFcmToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('fcmToken', token);
  }

  void _saveRefreshToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('refreshToken', token);
  }

  Future<String?> _getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  Future<String?> _getFcmToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('fcmToken');
  }

  Future<String?> _getRefreshToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('refreshToken');
  }

  void Function(BuildContext context) get logOut => _deleteToken;
  void Function(String) get saveToken => _saveToken;
  void Function(String) get saveFcmToken => _saveFcmToken;
  void Function(String) get saveRefreshToken => _saveRefreshToken;
  Future<String?> Function() get getToken => _getToken;
  Future<String?> Function() get getFcmToken => _getFcmToken;
  Future<String?> Function() get geRefreshtToken => _getRefreshToken;
  Function(BuildContext context) get getInitialRoute => _getInitialRoute;
}
