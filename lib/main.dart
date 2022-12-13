// ignore_for_file: prefer_const_constructors

import 'package:delivery/components/bottombar.dart';
import 'package:delivery/controller/main_controller.dart';
import 'package:delivery/router.dart';
import 'package:delivery/view/home/home.dart';
import 'package:delivery/view/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  Get.lazyPut(() => MainController());
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
      home: BottombarComponent(),
      getPages: routes(),
    );
  }
}
