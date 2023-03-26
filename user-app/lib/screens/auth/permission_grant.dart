import 'package:flutter/material.dart';
import 'package:paynless/res/routes.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class PermissonGrant extends StatefulWidget {
  const PermissonGrant({super.key});

  @override
  State<PermissonGrant> createState() => _PermissonGrantState();
}

class _PermissonGrantState extends State<PermissonGrant> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(14),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage('assets/images/bg_welcome.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/anims/enable-location-animation.json',
                  height: 200, width: 200),
              const SizedBox(
                height: 20,
              ),
              "Enable Location Services".text.xl2.bold.make(),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                icon: const Icon(
                  Icons.login,
                  color: Colors.white,
                ),
                label: const Text(
                  'Get Started',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(
                    const Size(200, 57),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    Colors.black,
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, MyRoute.loginPage);
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
