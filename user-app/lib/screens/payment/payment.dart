import 'dart:math';

import 'package:flutter/material.dart';
import 'package:paynless/handlers/auth_handler.dart';
import 'package:paynless/res/routes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../api/auth_services.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [Color(0xFFFFBE06), Color(0xFFFFA100)],
              )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  Card(
                    color: Colors.grey.shade200,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Medhelp 24x7", style: TextStyle(fontSize: 20)),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow.shade800,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow.shade800,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow.shade800,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow.shade800,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              ActionChip(
                                label: const Text("UPI"),
                                onPressed: () {},
                                backgroundColor: Colors.green,
                              ),
                              ActionChip(
                                label: const Text("CASH"),
                                onPressed: () {},
                                backgroundColor: Colors.green,
                              ),
                              const Spacer(),
                              ActionChip(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(MyRoute.paymentConf);
                                },
                                label: Row(
                                  children: [
                                    Icon(
                                      Icons.currency_rupee,
                                      size: 18,
                                      color: Colors.green,
                                    ),
                                    Text(
                                      "Pay via FamPay",
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            "Address:  Baruipur , Puratonbazar , 700144",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ClipRect(
                    child: Card(
                        color: Colors.black.withAlpha(40),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 100),
                          child: Text("Rs 700",
                              style:
                                  TextStyle(fontSize: 40, color: Colors.white)),
                        )),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Spacer(),
                  FloatingActionButton.extended(
                    label: const Text(
                      'Pay with FamPay',
                      style: (TextStyle(color: Colors.white)),
                    ),
                    backgroundColor: Colors.black,
                    onPressed: () async {
                      await launchUrl(
                          Uri.parse(
                              "https://play.google.com/store/apps/details?id=com.fampay.in"),
                          mode: LaunchMode.externalApplication);
                      Navigator.pushReplacementNamed(
                        context,
                        MyRoute.paymentConf,
                      );
                    },
                  ),
                  const Spacer(),
                ],
              ))),
    );
  }
}
