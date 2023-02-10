// ignore_for_file: prefer_const_constructors

import 'package:delivery/controller/main_controller.dart';
import 'package:delivery/router.dart';

import 'package:delivery/view/splash/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/cart_controller.dart';
import 'controller/location_controller.dart';
import 'controller/order_controller.dart';

void main() async {
  Get.lazyPut(() => MainController());
  Get.lazyPut(() => CartController());
  Get.lazyPut(() => LocationController());
  Get.lazyPut(() => OrderController());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      getPages: routes(),
    );
  }
}
