import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final firestore = FirebaseFirestore.instance;
  final orderModel = <OrderModel>[].obs;
  var isLoadingOrder = false.obs;
  Future<void> getMyOrder() async {
    isLoadingOrder(true);
    try {
      final QuerySnapshot querySnapshot =
          await firestore.collection('order').where('userID').get();
      orderModel.clear();
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        var data = querySnapshot.docs;
        orderModel.add(OrderModel(
          userId: data[i]['userID'],
          cartList: data[i]['cartList'],
          locationList: data[i]['locationlist'],
          totalPice: data[i]['totalPrice'],
          createdAt: data[i]['createdAt'],
          updatedAt: data[i]['updatedAt'],
        ));
        isLoadingOrder(false);
        update();
      }
    } catch (e) {
      isLoadingOrder(false);
      update();
      Get.snackbar(
        "get",
        "Error get order ",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

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
        "Error save order ",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
