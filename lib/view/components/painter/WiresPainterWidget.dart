import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:wire_viewer/model/vos/WireBlockVO.dart';
import 'package:wire_viewer/utils/PositionUtils.dart';

class WiresPainterWidget extends StatelessWidget {
  final WireBlockVO wireBlockVO;
  const WiresPainterWidget(this.wireBlockVO, {Key? key}) : super(key: key);

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

  PathPainter(this.wireBlockVO):super(repaint: wireBlockVO.position) {}

  void _drawDot(Canvas canvas, Point<double> position, [color = Colors.red]) => canvas.drawCircle(
    Offset(position.x, position.y), 4, Paint()..color = color);

  @override
  void paint(Canvas canvas, Size size) {
    if (wireBlockVO.connections == null) return;

    final Point<double> topLeft = PositionUtils.snapToGridPoint(wireBlockVO.topLeft);
    final Point<double> bottomRight = PositionUtils.snapToGridPoint(wireBlockVO.bottomRight);
    final Point<double> center = Point((topLeft.x + bottomRight.x) / 2, (topLeft.y + bottomRight.y) / 2);

    // _drawDot(canvas, center);
    // _drawDot(canvas, topLeft, Colors.pink);

    // List<CubicBezier> curves = wireBlockVO.connections!
    wireBlockVO.connections!
      .where((WireBlockVO c) => !c.block.intersects(wireBlockVO.block))
      .map((WireBlockVO c) {

      final Point<double> blockTopLeft = PositionUtils.snapToGridPoint(c.topLeft);
      final Point<double> blockBottomRight = PositionUtils.snapToGridPoint(c.bottomRight);
      final Point<double> blockCenter = Point((blockTopLeft.x + blockBottomRight.x) / 2, (blockTopLeft.y + blockBottomRight.y) / 2);

      // _drawDot(canvas, blockCenter);
      // _drawDot(canvas, blockTopLeft, Colors.pink);
      // _drawDot(canvas, blockBottomRight, Colors.blue);
      
      final blockFromLeft = blockCenter.x < topLeft.x;
      final blockFromTop = blockBottomRight.y < topLeft.y;
      final blockFromBottom = blockTopLeft.y > bottomRight.y;
      final blockInsideWidth = blockCenter.x > topLeft.x && blockCenter.x < bottomRight.x;

      Offset pStart = Offset(blockFromLeft ? topLeft.x : bottomRight.x, center.y);
      Offset pEnd = Offset(blockFromLeft ? blockBottomRight.x : blockTopLeft.x, blockCenter.y);

      if (blockFromTop) {
        pEnd = Offset(blockCenter.x, blockBottomRight.y);
        if (blockInsideWidth) pStart = Offset(center.x, topLeft.y);
      }
      else if (blockFromBottom) {
        pEnd = Offset(blockCenter.x, blockTopLeft.y);
        if (blockInsideWidth) pStart = Offset(center.x, bottomRight.y);
      }

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

      // Point<double> pOne = Point(
      //   blockInsideWidth ? pStart.x : (pStart.x + pEnd.x) / 2,
      //   blockFromTop ? (pStart.y + pEnd.y) / 2 : pStart.y
      // );
      // Point<double> pTwo = Point(
      //   blockFromTop ? pEnd.x : (pStart.x + pEnd.x) / 2,
      //   blockFromBottom ? (pStart.y + pEnd.y) / 2 : pEnd.y
      // );

      // return CubicBezier([
      //   math.Vector2(pStart.x, pStart.y),
      //   math.Vector2(pOne.x, pOne.y),
      //   math.Vector2(pTwo.x, pTwo.y),
      //   math.Vector2(pEnd.x, pEnd.y),
      // ]);
    }).toList();

    // curves.forEach((curve) {
    //   final points = curve.points;
    //   canvas.drawPoints(ui.PointMode.points,
    //     points
    //       // .where((p) => [0, 3].contains(points.indexOf(p)))
    //       .map((p) => Offset(p.x, p.y)).toList(),
    //     Paint()
    //       ..color = Colors.black
    //       ..strokeWidth = 10
    //       ..strokeCap = StrokeCap.round
    //   );
    //
    //   final path = Path()
    //     ..moveTo(points.first.x, points.first.y)
    //     ..cubicTo(points[1].x, points[1].y, points[2].x, points[2].y, points.last.x, points.last.y);
    //   canvas.drawPath(path,
    //     Paint()
    //       ..color = Colors.black
    //       ..style = PaintingStyle.stroke
    //       ..strokeWidth = 2
    //   );
    // });
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return true;
  }
}
