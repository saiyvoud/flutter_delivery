// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:delivery/controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final MainController controller = Get.put(MainController());
  @override
  void initState() {
    super.initState();

    controller.validateAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: 50, vertical: 120),
                child: Lottie.asset("assets/animations/logo.json")),
            Text(
              "Please loading...",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
