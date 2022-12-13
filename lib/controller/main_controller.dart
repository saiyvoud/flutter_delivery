import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/model/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class MainController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final productList = <ProductModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await fecthProduct();
  }

  Future fecthProduct() async {
    isLoading(true);
    try {
      final QuerySnapshot querySnapshot =
          await firestore.collection("product").get();
      productList.clear();
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        var data = querySnapshot.docs;
        productList.add(ProductModel(
          productID: data[i].id,
          name: data[i]['name'],
          desc: data[i]['desc'],
          amount: data[i]['amount'],
          price: data[i]['price'],
          image: data[i]['img'],
        ));
      }
      isLoading(false);
      update();
    } catch (e) {
      Get.snackbar(
        "error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      isLoading(false);
      update();
    }
  }

  login(email, password) async {
    try {
      /// A function that is used to sign in with email and password.
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Get.snackbar("Login", "Login Successful",
            backgroundColor: Colors.green, colorText: Colors.white);
      });
    } catch (e) {
      Get.snackbar("Error Login", "${e.toString()}",
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }

  register(firstname, lastname, email, password) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        firestore.collection("user").doc(value.user!.uid).set({
          "firstname": firstname,
          "lastname": lastname,
          "email": email,
          "password": password,
        }).then((value) {
          Get.snackbar("Register", "Register Successful",
              colorText: Colors.white, backgroundColor: Colors.green);
        });
      });
    } catch (e) {
      Get.snackbar("Error Register", "${e.toString()}",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
