import 'package:flutter/material.dart';

class BottomWave extends CustomPainter {
  final Color color1;
  final Color color2;
  final Color color3;
  BottomWave(this.color1, this.color2, this.color3);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = Paint()
      ..color = color1
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path_0 = Path();
    path_0.moveTo(size.width * 1.0019133, size.height * 0.8109603);
    path_0.lineTo(size.width * 1.0019133, size.height * 1.0032266);
    path_0.lineTo(size.width * -0.0109184, size.height * 1.0032266);
    path_0.lineTo(size.width * -0.0110459, size.height * 0.8053265);
    path_0.lineTo(size.width * 1.0019133, size.height * 0.8109603);
    path_0.close();

    canvas.drawPath(path_0, paint_0);

    Paint paint_1 = Paint()
      ..color = color2
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.0008163, size.height * 0.8537260);
    path_1.quadraticBezierTo(size.width * 0.1092857, size.height * 0.9620999,
        size.width * 0.3113520, size.height);
    path_1.cubicTo(
        size.width * 0.3908673,
        size.height * 0.7818182,
        size.width * 0.7316327,
        size.height * 0.8039181,
        size.width,
        size.height * 0.8669910);
    path_1.quadraticBezierTo(size.width, size.height * 0.8152241, size.width,
        size.height * 0.7109731);
    path_1.quadraticBezierTo(size.width * 0.7243367, size.height * 0.6123303,
        size.width * 0.5419388, size.height * 0.6262356);
    path_1.quadraticBezierTo(size.width * 0.1067092, size.height * 0.6504225,
        size.width * 0.0000765, size.height * 0.5519846);
    path_1.lineTo(size.width * 0.0008163, size.height * 0.8537260);
    path_1.close();
    canvas.drawPath(path_1, paint_1);

    Paint paint_2 = Paint()
      ..color = color3
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path_2 = Path();
    path_2.moveTo(size.width, size.height * 0.5689373);
    path_2.quadraticBezierTo(size.width * 0.8773214, size.height * 0.5718182,
        size.width * 0.8025510, size.height * 0.5803201);
    path_2.quadraticBezierTo(size.width * 0.6752296, size.height * 0.5986556,
        size.width * 0.5275510, size.height * 0.6280666);
    path_2.quadraticBezierTo(size.width * 0.8009184, size.height * 0.6280538,
        size.width, size.height * 0.7195903);
    path_2.quadraticBezierTo(size.width, size.height * 0.6800128, size.width,
        size.height * 0.5689373);
    path_2.close();

    canvas.drawPath(path_2, paint_2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
