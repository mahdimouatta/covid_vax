import 'package:flag/flag.dart';
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
        Flag(
          code.substring(0, max(0, code.length - 1)),
          height: 50,
          width: 30,
        ),
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
