// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field, prefer_final_fields

import 'package:delivery/view/home/home.dart';
import 'package:delivery/view/order/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BottombarComponent extends StatefulWidget {
  const BottombarComponent({super.key});

  @override
  State<BottombarComponent> createState() => _BottombarComponentState();
}

class _BottombarComponentState extends State<BottombarComponent> {
  List<Widget> _children = [
    HomeView(),
    MyOrder(),
  ];
  int currentIndex = 0;
  void _onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.purple.shade500,
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        elevation: 5,
        onTap: _onTap,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: "order",
          ),
        ],
      ),
    );
  }
}
