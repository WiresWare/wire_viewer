import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:wire_viewer/model/vos/WireBlockVO.dart';
import 'package:wire_viewer/utils/PositionUtils.dart';

class WiresPainter extends StatelessWidget {
  final WireBlockVO wireBlockVO;
  const WiresPainter(this.wireBlockVO, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: ui.window.physicalSize,
        painter: PathPainter(wireBlockVO),
      ),
    );
  }
}

class PathPainter extends CustomPainter {
  final WireBlockVO wireBlockVO;

  PathPainter(this.wireBlockVO):super();

  void _drawDot(Canvas canvas, Point<double> position, [color = Colors.red]) => canvas.drawCircle(
    Offset(position.x, position.y), 4, Paint()..color = color);

  @override
  void paint(Canvas canvas, Size size) {
    if (wireBlockVO.connections == null) return;

    // _drawDot(canvas, center);
    // _drawDot(canvas, topLeft, Colors.pink);

    final connectionPoints = wireBlockVO.connectionPoints;
    wireBlockVO.connections!.map((WireBlockVO c) {
      Point<double> pOne = connectionPoints[0];
      Point<double> pTwo = c.connectionPoints[0];
      double
        minDistance = double.infinity,
        testDistance = double.infinity;

      connectionPoints.forEach((p1) {
        c.connectionPoints.forEach((p2) {
          testDistance = p1.distanceTo(p2);
          if (testDistance < minDistance) {
            pOne = p1; pTwo = p2;
            minDistance = testDistance;
          }
        });
      });

      pOne = PositionUtils.snapToGridPoint(pOne);
      pTwo = PositionUtils.snapToGridPoint(pTwo);

      Offset pStart = Offset(pOne.x, pOne.y);
      Offset pEnd = Offset(pTwo.x, pTwo.y);

      canvas.drawPoints(ui.PointMode.points, [ pStart, pEnd ], Paint()
        ..color = Colors.black
        ..strokeWidth = 10
        ..strokeCap = StrokeCap.round
      );

      canvas.drawLine(pStart, pEnd, Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
      );
    }).toList();
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return true;
  }
}
