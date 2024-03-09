import 'package:flutter/material.dart';

class SmallBottomWave extends CustomPainter {
  final Color color1;
  final Color color2;
  final Color color3;

  SmallBottomWave(this.color1, this.color2, this.color3);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = Paint()
      ..color = color1
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.4854750);
    path_0.lineTo(0, size.height);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(size.width, size.height * 0.4882750);
    path_0.lineTo(0, size.height * 0.4854750);
    path_0.close();

    canvas.drawPath(path_0, paint_0);

    Paint paint_1 = Paint()
      ..color = color2
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.5052041, size.height * 0.2944000);
    path_1.quadraticBezierTo(size.width * 0.8680867, size.height * 0.1225250,
        size.width, size.height * 0.1203500);
    path_1.lineTo(size.width, size.height * 0.3784500);
    path_1.quadraticBezierTo(size.width * 0.8137755, size.height * 0.3930500,
        size.width * 0.5052041, size.height * 0.2944000);
    path_1.close();

    canvas.drawPath(path_1, paint_1);

    Paint paint_2 = Paint()
      ..color = color3
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.2623469, size.height * 0.9973000);
    path_2.cubicTo(
        size.width * 0.0948214,
        size.height * 0.9173500,
        size.width * 0.0121939,
        size.height * 0.7715500,
        size.width * 0.0025510,
        size.height * 0.7125000);
    path_2.quadraticBezierTo(size.width * 0.0019133, size.height * 0.5600000, 0,
        size.height * 0.1025000);
    path_2.quadraticBezierTo(size.width * 0.1583418, size.height * 0.3011250,
        size.width * 0.6331888, size.height * 0.2367000);
    path_2.quadraticBezierTo(size.width * 0.8815816, size.height * 0.2316750,
        size.width, size.height * 0.3702500);
    path_2.quadraticBezierTo(size.width * 0.9993622, size.height * 0.6150000,
        size.width, size.height * 0.6950000);
    path_2.cubicTo(
        size.width * 0.3690561,
        size.height * 0.4254000,
        size.width * 0.2984439,
        size.height * 0.8939250,
        size.width * 0.2623469,
        size.height * 0.9973000);
    path_2.close();

    canvas.drawPath(path_2, paint_2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
