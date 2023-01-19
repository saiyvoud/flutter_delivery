// ignore_for_file: prefer_const_constructors

import 'package:delivery/components/bottombar.dart';
import 'package:delivery/view/cart/cart.dart';
import 'package:delivery/view/home/home.dart';
import 'package:delivery/view/login.dart';
import 'package:delivery/view/payment/add_time.dart';
import 'package:delivery/view/payment/address.dart';
import 'package:delivery/view/payment/payment.dart';
import 'package:delivery/view/register.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

routes() => [
      GetPage(name: '/login', page: () => Login()),
      GetPage(name: '/register', page: () => Register()),
      GetPage(name: '/home', page: () => HomeView()),
      GetPage(name: '/bottombar', page: () => BottombarComponent()),
      GetPage(name: '/cart', page: () => CartView()),
      GetPage(name: '/payment', page: () => PaymentView()),
      GetPage(name: '/address', page: () => Address()),
      GetPage(name: '/time', page: () => AddTime()),
    ];
