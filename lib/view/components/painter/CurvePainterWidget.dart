import 'dart:math';
import 'dart:ui' as ui;

import 'package:bezier/bezier.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as math;
import 'package:wire_viewer/model/vos/ConnectionVO.dart';

class CurvePainterWidget extends StatelessWidget {
  final List<ConnectionVO> connections;
  const CurvePainterWidget(this.connections, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: ui.window.physicalSize,
        painter: PathPainter(connections),
      ),
    );
  }
}

class PathPainter extends CustomPainter {
  final List<ConnectionVO> connections;
  final List<CubicBezier> curves = [];
  PathPainter(this.connections) {
    connections.forEach((connection) {
      Point<double> p1 = connection.start;
      Point<double> p2 = connection.end;
      final curve = CubicBezier([
        math.Vector2(p1.x, p1.y),
        math.Vector2((p1.x + p2.x) / 2, p1.y),
        math.Vector2((p1.x + p2.x) / 2, p2.y),
        math.Vector2(p2.x, p2.y),
      ]);
      curves.add(curve);
    });
  }

  @override
  void paint(Canvas canvas, Size size) {
    curves.forEach((curve) {
      final points = curve.points;
      canvas.drawPoints(ui.PointMode.points,
        points
          .where((p) => [0, 3].contains(points.indexOf(p)))
          .map((p) => Offset(p.x, p.y)).toList(),
        Paint()
          ..color = Colors.black
          ..strokeWidth = 10
          ..strokeCap = StrokeCap.round
      );
      final path = Path()
        ..moveTo(points.first.x, points.first.y)
        ..cubicTo(points[1].x, points[1].y, points[2].x, points[2].y, points.last.x, points.last.y);
      canvas.drawPath(path,
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
      );
    });
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
