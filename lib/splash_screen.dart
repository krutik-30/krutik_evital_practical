import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:krutik_evital_practical/Login/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    animation = CurvedAnimation(
      parent: controller!,
      curve: Curves.easeInOut,
    );

    controller?.forward();

    Timer(const Duration(seconds: 5), () {
      Get.offAll(() => const LoginPageView());
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal, Colors.tealAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ScaleTransition(
                scale: animation!,
                child: const CircleAvatar(
                  radius: 60.0,
                  backgroundImage: AssetImage('assets/images/splash_logo.png'),
                ),
              ),
              const SizedBox(height: 20),
              FadeTransition(
                opacity: animation!,
                child: const Text(
                  "Welcome to MyApp",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
