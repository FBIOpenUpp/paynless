import 'dart:math';

import 'package:flutter/material.dart';
import 'package:paynless/handlers/auth_handler.dart';
import 'package:paynless/res/routes.dart';

import '../../api/auth_services.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final authHandler = AuthApi();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void login() {
    authHandler.googleAuth(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [Color(0xFFFFBE06), Color(0xFFFFA100)],
              )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  SizedBox(
                    height: 144,
                    width: 150,
                    child: Stack(
                      children: [
                        Positioned.fill(
                            child: SizedBox(
                          height: 144,
                          width: 164,
                        )),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            'Business',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        Positioned.fill(
                          child: Image.asset(
                            'assets/images/logo.png',
                            height: 144,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Spacer(),
                  FloatingActionButton.extended(
                    label: const Text(
                      'Sign in with Google',
                      style: (TextStyle(color: Colors.white)),
                    ),
                    icon: Image.asset(
                      'assets/images/google.png',
                      height: 20,
                      width: 20,
                    ),
                    backgroundColor: Colors.black,
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context, MyRoute.clientFormPhone, (route) => false);
                    },
                  ),
                  const Spacer(),
                ],
              ))),
    );
  }
}
