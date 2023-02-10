// ignore_for_file: prefer_const_constructors

import 'package:delivery/components/data.dart';
import 'package:flutter/material.dart';

class MenuComponent extends StatelessWidget {
  const MenuComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      // decoration: BoxDecoration(color: Colors.red),
      child: GridView.builder(
          shrinkWrap: true,
          primary: false,
          scrollDirection: Axis.horizontal,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: menu.length,
          itemBuilder: ((context, index) {
            return Column(
              children: [
                Image.asset('${menu[index]["img"]}'),
                SizedBox(height: 5),
                Text('${menu[index]['name']}'),
              ],
            );
          })),
    );
  }
}
