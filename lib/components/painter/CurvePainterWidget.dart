import 'dart:ui' as ui;

import 'package:bezier/bezier.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as math;

class CurvePainterWidget extends StatelessWidget {
  final List<Offset> points;
  const CurvePainterWidget(this.points, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: ui.window.physicalSize,
        painter: PathPainter(points),
      ),
    );
  }
}

class PathPainter extends CustomPainter {
  final List<Offset> points;
  late final QuadraticBezier curve;
  PathPainter(this.points) {
    curve = QuadraticBezier([...points.map((p) => math.Vector2(p.dx, p.dy)).toList(), math.Vector2(0, 0)]);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final pts = curve.points;
    final path = Path()
      // ..moveTo(points.first.dx, points.first.dy)
      // ..quadraticBezierTo((points.first.dx + points.last.dx) * 0.5, (points.first.dy + points.last.dy) * 0.5,
      //     points.last.dx, points.last.dy);
      ..moveTo(pts.first.x, pts.first.y)
      ..quadraticBezierTo(pts.last.x, pts.last.y, pts[1].x, pts[1].y);
    // final path = Path();
    // path.moveTo(pts[0].x, pts[0].y);
    // path.cubicTo(pts[1].x, pts[1].y, pts[2].x, pts[2].y, pts[3].x, pts[3].y);
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
