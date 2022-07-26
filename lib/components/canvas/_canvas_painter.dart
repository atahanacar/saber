
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '_stroke.dart';

class CanvasPainter extends CustomPainter {
  const CanvasPainter({
    required this.strokes,
    this.currentStroke,
  });

  final List<Stroke> strokes;
  final Stroke? currentStroke;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round;
    for (final Stroke stroke in strokes) {
      paint.color = stroke.color;
      Path path = Path();
      path.addPolygon(stroke.getPolygon(), true);
      canvas.drawPath(path, paint);
    }
    if (currentStroke != null) {
      paint.color = currentStroke!.color;
      Path path = Path();
      path.addPolygon(currentStroke!.getPolygon(), true);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CanvasPainter oldDelegate) => true;
}
