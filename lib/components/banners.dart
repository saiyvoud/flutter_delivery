// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:delivery/components/data.dart';
import 'package:flutter/material.dart';

class BannersComponents extends StatefulWidget {
  const BannersComponents({super.key});

  @override
  State<BannersComponents> createState() => _BannersComponentsState();
}

class _BannersComponentsState extends State<BannersComponents> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _banner(),
        SizedBox(height: 10),
        //  _inditor(),
      ],
    );
  }

  Widget _banner() {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        height: 140,
        viewportFraction: 1,
      ),
      items: banner.map((e) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              e,
              fit: BoxFit.cover,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _inditor() {
    return Row(
      children: [],
    );
  }
}
