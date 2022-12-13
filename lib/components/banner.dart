// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:delivery/components/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class BannerComponents extends StatefulWidget {
  const BannerComponents({super.key});

  @override
  State<BannerComponents> createState() => _BannerComponentsState();
}

class _BannerComponentsState extends State<BannerComponents> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _banner(),
        SizedBox(height: 5),
        _indotor(),
      ],
    );
  }

  int _current = 0;
  _banner() {
    return CarouselSlider(
      options: CarouselOptions(
          height: 120.0,
          autoPlay: true,
          scrollDirection: Axis.horizontal,
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          }),
      items: banner
          .map(
            (i) => Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(color: Colors.amber),
              child: Image.asset(
                i,
                fit: BoxFit.cover,
              ),
            ),
          )
          .toList(),
    );
  }

  _indotor() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: banner.map((url) {
        int index = banner.indexOf(url);
        return Container(
          width: 8,
          height: _current == index ? 8 : 5,
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            shape: _current == index ? BoxShape.circle : BoxShape.circle,
            color: Colors.purple,
          ),
        );
      }).toList(),
    );
  }
}
