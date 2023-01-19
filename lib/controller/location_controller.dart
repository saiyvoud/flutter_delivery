import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/location_model.dart';

class LocationController extends GetxController {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final locationList = <LocationModel>[].obs;
  var locationLoading = false.obs;

  Future<void> getLocation() async {
    locationLoading(true);
    try {
      await firestore
          .collection('location')
          .where('userId', isEqualTo: auth.currentUser!.uid)
          .get()
          .then((value) {
        locationList.clear();
        for (int i = 0; i < value.docs.length; i++) {
          var data = value.docs;
          locationList.add(
            LocationModel(
              id: data[i].id,
              address: data[i]['address'],
              type: data[i]['type'],
              location: data[i]['location'],
            ),
          );
        }
        locationLoading(false);
        update();
      });
    } catch (e) {
      locationLoading(false);
      update();
      rethrow;
    }
  }

  Future<void> addLocation({
    required String address,
    required String type,
    required String day,
    required String time,
    required double lat,
    required double lng,
    required String userId,
  }) async {
    try {
      await firestore.collection('location').doc().set({
        'address': address,
        'type': type,
        'day': day,
        'time': time,
        'location': GeoPoint(lat, lng),
        'userId': userId,
      }).then((value) {
        Get.snackbar(
          "add",
          "add Location Successful",
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
      });
    } catch (e) {
      Get.snackbar(
        "error add location",
        e.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }
}
