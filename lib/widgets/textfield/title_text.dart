import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  TitleText(this.text, this.size, this.color);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(fontSize: size, color: color, fontWeight: FontWeight.bold),
    );
  }
}
