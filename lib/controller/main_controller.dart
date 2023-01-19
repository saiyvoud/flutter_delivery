import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/model/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../model/user_model.dart';

class MainController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final productList = <ProductModel>[].obs;
  final userModel = <UserModel>[].obs;
  var isLoading = false.obs;
  var userLoading = false.obs;
  @override
  void onInit() async {
    super.onInit();
    await fecthProduct();
  }

  Future<void> getUser() async {
    userLoading(true);
    try {
      await firestore
          .collection('user')
          .doc(auth.currentUser!.uid)
          .get()
          .then((value) {
        userModel.add(UserModel(
          id: auth.currentUser!.uid,
          firstName: value.data()!['firstName'],
          lastName: value.data()!['lastName'],
          email: value.data()!['email'],
          phoneNumber: value.data()!['phoneNumber'],
        ));
        userLoading(false);
        update();
      });
    } catch (e) {
      userLoading(false);
      update();
      rethrow;
    }
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
          .then((value) async {
        Get.snackbar("Login", "Login Successful",
            backgroundColor: Colors.green, colorText: Colors.white);
        await fecthProduct();
        Get.offAllNamed('/bottombar');
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
        }).then((value) async {
          Get.snackbar("Register", "Register Successful",
              colorText: Colors.white, backgroundColor: Colors.green);
          await fecthProduct();

          Get.offAllNamed('/bottombar');
        });
      });
    } catch (e) {
      Get.snackbar("Error Register", "${e.toString()}",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> logout() async {
    await auth.signOut();
    Get.offAllNamed("/login");
  }

  void validateAuth() {
    if (auth.currentUser == null) {
      Get.offAllNamed("/login");
    } else {
      Get.offAllNamed("/bottombar");
    }
  }
}
