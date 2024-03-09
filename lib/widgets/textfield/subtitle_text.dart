import 'package:flutter/material.dart';

class SubtitleText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;

  SubtitleText(this.text, this.size, this.color);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: color,
      ),
      textAlign: TextAlign.center,
    );
  }
}
