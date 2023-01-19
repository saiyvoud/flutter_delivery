import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/cart_model.dart';

class CartController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final List cartList = [];
  final cartModel = <CartModel>[].obs;
  var isCartLoading = false.obs;
  var totalPrice = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    await getCart();
    await getTotalPrice();
  }

  // Future<void> removeTotalPrice({required String id}) async {
  //   try {
  //     await firestore.collection("cart").doc(id).get().then((value) {
  //       totalPrice -= value.data()!['amount'] * value.data()!['price'];

  //       update();
  //     });
  //   } catch (e) {
  //     Get.snackbar(
  //       "erorr get Total cart",
  //       e.toString(),
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //   }
  // }

  Future<void> getTotalPrice() async {
    try {
      totalPrice = 0.obs;
      await firestore
          .collection("cart")
          .where("userID", isEqualTo: auth.currentUser!.uid)
          .get()
          .then((value) {
        for (var total in value.docs) {
          totalPrice += total['amount'] * total['price'];
        }
        update();
      });
    } catch (e) {
      Get.snackbar(
        "erorr get Total cart",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> removeCart({
    required String id,
    required int amount,
  }) async {
    try {
      await firestore.collection("cart").doc(id).update({
        "amount": amount - 1,
      }).then((value) async {
        await getTotalPrice();
        await getCart();

        Get.snackbar(
          "remove",
          "remove amount in cart",
          backgroundColor: Colors.amber,
          colorText: Colors.white,
        );
        update();
      });
    } catch (e) {
      Get.snackbar(
        "erorr remove cart",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> deleteCart({required String id}) async {
    try {
      await firestore.collection("cart").doc(id).delete().then((value) async {
        await getTotalPrice();
        await getCart();
        Get.snackbar(
          "delete",
          "delete cart successful",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        update();
      });
    } catch (e) {
      Get.snackbar(
        "error delete",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> addCart({required String id, required int amount}) async {
    try {
      await firestore.collection("cart").doc(id).update({
        "amount": amount + 1,
      }).then((value) async {
        await getTotalPrice();
        await getCart();
        Get.snackbar(
          "error delete",
          "update amount in cart successful",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        update();
      });
    } catch (e) {
      Get.snackbar(
        "error add cart",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> addProductToCart({
    required String productID,
    required String name,
    required String desc,
    required int amount,
    required int price,
    required String img,
  }) async {
    try {
      await firestore
          .collection("cart")
          .where("userID", isEqualTo: auth.currentUser!.uid)
          .get()
          .then((value) {
        for (var element in value.docs) {
          cartList.add(element.id);
        }
      });

      if (cartList.contains(productID)) {
        await firestore.collection("cart").doc(productID).get().then((value) {
          value.reference.update({
            "amount": value.data()!['amount'] + 1,
          }).then((value) async {
            await getTotalPrice();
            await getCart();
            Get.snackbar("update", "update product in cart",
                colorText: Colors.white, backgroundColor: Colors.amber);
          });
        });
      } else {
        await firestore.collection("cart").doc(productID).set({
          'productID': productID,
          'name': name,
          'desc': desc,
          'amount': 1,
          'price': price,
          'img': img,
          'userID': user!.uid,
        }).then((value) async {
          Get.snackbar("add", "add product in cart",
              colorText: Colors.white, backgroundColor: Colors.green);
          await getCart();
          await getTotalPrice();
          update();
        });
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }

  Future getCart() async {
    isCartLoading(true);
    try {
      final QuerySnapshot querySnapshot = await firestore
          .collection("cart")
          .where("userID", isEqualTo: auth.currentUser!.uid)
          .get();
      cartModel.clear();
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        var data = querySnapshot.docs[i];
        cartModel.add(CartModel(
          cartID: data.id,
          productID: data['productID'],
          name: data['name'],
          desc: data['desc'],
          amount: data['amount'],
          price: data['price'],
          img: data['img'],
          userID: auth.currentUser!.uid,
        ));
        print(cartModel.length);
      }
      isCartLoading(false);
      update();
    } catch (e) {
      Get.snackbar("Error get cart", e.toString(),
          colorText: Colors.white, backgroundColor: Colors.red);
      isCartLoading(false);
      update();
    }
  }
}
