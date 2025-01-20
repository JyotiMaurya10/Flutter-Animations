import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/quiz_controller.dart';
import 'package:quiz_app/utils/colors.dart';

class ArrowAnimation extends StatelessWidget {
  const ArrowAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    final QuizController controller = Get.find();

    return Obx(
      () => CustomPaint(
        size: Size(controller.arrowLength.value, 10),
        painter: ArrowPainter(controller.arrowLength.value),
      ),
    );
  }
}

class ArrowPainter extends CustomPainter {
  final double arrowLength;

  ArrowPainter(this.arrowLength);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = primaryColor
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(arrowLength, size.height / 2),
      paint,
    );

    final Paint arrowHeadPaint = Paint()
      ..color = primaryColor
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round;

    const double arrowHeadLength = 5.0;

    canvas.drawLine(
      Offset(arrowLength, size.height / 2),
      Offset(arrowLength - arrowHeadLength, size.height / 2 - arrowHeadLength),
      arrowHeadPaint,
    );
    canvas.drawLine(
      Offset(arrowLength, size.height / 2),
      Offset(arrowLength - arrowHeadLength, size.height / 2 + arrowHeadLength),
      arrowHeadPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
