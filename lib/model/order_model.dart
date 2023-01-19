// ignore_for_file: unnecessary_this, prefer_interpolation_to_compose_strings

import 'cart_model.dart';
import 'location_model.dart';

class OrderModel {
  final List<LocationModel>? locationList;
  final List<CartModel>? cartList;
  final String? userId;
  final String? totalPice;
  final String? createdAt;
  final String? updatedAt;
  OrderModel(
      {this.locationList,
      this.cartList,
      this.userId,
      this.totalPice,
      this.createdAt,
      this.updatedAt});
  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
      locationList: List<LocationModel>.from(
          json['locationList']?.map((x) => LocationModel.fromJson(x))),
      cartList: List<CartModel>.from(
          json['cartList']?.map((x) => CartModel.fromJson(x))),
      userId: json['userId'],
      totalPice: json['totalPrice'],
      createdAt: json['createaAt'],
      updatedAt: json['updatedAt']);
  Map<String, dynamic> toJson() => {
        'locationList': locationList?.map((x) => x.toJson()).toList(),
        'cartList': cartList?.map((e) => e.toJson()).toList(),
        'user': userId,
        'totalPrice': totalPice,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
