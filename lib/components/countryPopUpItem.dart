import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountryPopUpItem extends StatelessWidget {
  final String name;
  final String code;

  CountryPopUpItem({this.name, this.code});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        Text(
          name,
          style: TextStyle(
            color: Color(0xFF19AAB1),
          ),
        ),
      ],
    );
  }
}

int max(a, b) {
  return a > b ? a : b;
}
