import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final firestore = FirebaseFirestore.instance;

  Future<void> saveOrder({required OrderModel orderModel}) async {
    try {
      firestore
          .collection('order')
          .doc()
          .set(orderModel.toJson())
          .then((value) {
        Get.snackbar(
          "save",
          "save order successful",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed('/bottombar');
      });
    } catch (e) {
      Get.snackbar(
        "save",
        "save order successful",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
