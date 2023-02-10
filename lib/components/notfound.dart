// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

Widget notFound() {
  return SingleChildScrollView(
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 220),
      child: Column(
        children: [
          Center(
            child: Icon(
              Icons.error,
              size: 30,
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              'ຍັງບໍ່ມີຂໍ້ມູນ',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
        ],
      ),
    ),
  );
}
