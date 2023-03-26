import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:paynless/handlers/auth_handler.dart';
import 'package:paynless/res/toast.dart';
import 'package:paynless/services/http_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';
import '../res/constraints.dart';
import '../res/routes.dart';

class AuthApi {
  final http = HttpService();
  //signup

  Future<void> googleAuth({
    required BuildContext context,
  }) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
      'email',
    ]);
    try {
      final GoogleSignInAccount? gUser = await _googleSignIn.signIn();
      log(gUser.toString());
      var body = {
        'id': gUser!.id,
        'name': gUser.displayName,
        'email': gUser.email,
        'avatarUrl': gUser.photoUrl,
      };
      final res = await http.post(path: googleAuthApi, body: body);
      log(res.data.toString());
      if (res.statusCode == 200 || res.statusCode == 201) {
        Provider.of<UserProvider>(context, listen: false)
            .setUser(User.fromJson(body));
        AuthHandler().saveToken(res.data['access_token']);
        bool isPermitted = await Permission.locationAlways.isGranted;
        if (!isPermitted) {
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
        showToast('Something went wrong');
        Timer(
            const Duration(seconds: 2),
            () =>
                Navigator.of(context).pushReplacementNamed(MyRoute.loginPage));
      }
      // Provider.of<UserProvider>(context, listen: false)
      //     .setUser(User.fromJson(body));
      // AuthHandler().saveToken(json.encode(body));
      // bool isPermitted = await Permission.locationAlways.isGranted;
      // if (!isPermitted) {
      //   Timer(
      //       const Duration(seconds: 2),
      //       () => Navigator.of(context).pushNamedAndRemoveUntil(
      //           MyRoute.permissionGranted, (Route<dynamic> route) => false));
      // } else {
      //   Timer(
      //       const Duration(seconds: 2),
      //       () => Navigator.of(context).pushNamedAndRemoveUntil(
      //           MyRoute.dashboard, (Route<dynamic> route) => false));
      // }
    } catch (e) {
      log(e.toString());
      showToast('Something went wrong');
    }
  }

  //get user data
  Future<User?> getUserData({required String token}) async {
    try {
      final res = await http.getWithHeader(path: getUserDataApi, header: token);
      log(res.data.toString());
      if (res.statusCode == 200) {
        return User.fromJson(res.data);
      }
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  //update user data
}
