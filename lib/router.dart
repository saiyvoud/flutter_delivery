// ignore_for_file: prefer_const_constructors

import 'package:delivery/view/home/home.dart';
import 'package:delivery/view/login.dart';
import 'package:delivery/view/register.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

routes() => [
      GetPage(name: '/login', page: () => Login()),
      GetPage(name: '/register', page: () => Register()),
      GetPage(name: '/home', page: () => HomeView()),
    ];
