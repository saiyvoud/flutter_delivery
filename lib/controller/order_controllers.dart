import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/model/order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class OrderControllers extends GetxController {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  Future<void> saveOrder({required OrderModel orderModel}) async {
    try {
      await firestore
          .collection('order')
          .doc()
          .set(orderModel.toJson())
          .then((value) {
        Get.snackbar(
          'save',
          'save order successful',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      });
    } catch (e) {
      Get.snackbar(
        'error ',
        'error save order ',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
