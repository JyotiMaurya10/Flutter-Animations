import 'package:flutter/material.dart';
import 'package:quiz_app/utils/colors.dart';

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lightColor.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final path1 = Path()
      ..moveTo(size.width * 0.2, 0)
      ..quadraticBezierTo(
        size.width * 0.4,
        size.height * 0.2,
        size.width * 0.6,
        size.height * 0.12,
      )
      ..quadraticBezierTo(
        size.width * 0.8,
        size.height * 0.05,
        size.width,
        size.height * 0.3,
      )
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path1, paint);

    final path2 = Path()
      ..moveTo(size.width, size.height * 0.6)
      ..quadraticBezierTo(
        size.width * 0.7,
        size.height,
        size.width * 0.5,
        size.height * 0.8,
      )
      ..quadraticBezierTo(
        size.width * 0.2,
        size.height * 0.5,
        0,
        size.height * 0.8,
      )
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
