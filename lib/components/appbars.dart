// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'color.dart';




AppBar appbar(BuildContext context) {
  return AppBar(
    backgroundColor: primaryColor,
    leading: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: primaryColorWhite,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Icon(
          Icons.person,
          color: primaryColor,
        ),
      ),
    ),
    title: Text(
      "Park Shopee",
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: primaryColorWhite,
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: primaryColorRed,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(child: Text('0')),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.shopping_cart,
                color: primaryColorWhite,
              ),
            ),
          ],
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.exit_to_app,
          color: primaryColorWhite,
        ),
      ),
    ],
  );
}
