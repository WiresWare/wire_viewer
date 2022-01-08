import 'dart:math';
import 'dart:ui' as ui;

import 'package:bezier/bezier.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as math;
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

  @override
  void paint(Canvas canvas, Size size) {
    if (wireBlockVO.connections == null) return;

    Point<double> start = wireBlockVO.position.value;
    final positionXSideLeft = PositionUtils.snapToGrid(wireBlockVO.left);
    final positionXSideRight = PositionUtils.snapToGrid(wireBlockVO.right);
    
    List<CubicBezier> curves = wireBlockVO.connections!.map((WireBlockVO connectionWireBlockVO) {
      final block = connectionWireBlockVO.block;
      final blockX = block.left, blockY = block.top;
      final fromLeft = blockX < start.x;
      final fromTop = blockY > start.y;
      final double startX = fromLeft ? positionXSideLeft : positionXSideRight;
      return CubicBezier([
        math.Vector2(startX, start.y),
        math.Vector2((startX + blockX) / 2, start.y),
        math.Vector2((startX + blockX) / 2, blockY),
        math.Vector2(blockX, blockY),
      ]);
    }).toList();

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
    return true;
  }
}
