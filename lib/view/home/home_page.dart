// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:delivery/components/banner.dart';
import 'package:flutter/material.dart';

import '../../components/appbars.dart';
import '../../components/banners.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(height: 10),
            BannersComponents(),
          ],
        ),
      ),
    );
  }
}
