import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wire_viewer/model/vos/screen_info_vo.dart';
import 'package:wire_viewer/model/vos/wire_block_vo.dart';
import 'package:wire_viewer/utils/utils_position.dart';
import 'package:wire_viewer/view/components/movable/movable_block.dart';

class WireBlocksLayer extends StatefulWidget {
  const WireBlocksLayer(this.blocks, this.screenInfoVO, { Key? key }) : super(key: key);

  final List<WireBlockVO> blocks;
  final ScreenInfoVO screenInfoVO;

  @override
  State<WireBlocksLayer> createState() => _WireBlocksLayerState();
}

class _WireBlocksLayerState extends State<WireBlocksLayer> {
  late Size _renderSize;

  @override
  void initState() {
    super.initState();
    _renderSize = widget.screenInfoVO.size.value * widget.screenInfoVO.scale.value;
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(top: 8, left: 16, child: Text('Screen size: ${_renderSize.toString()} | scaleFactor: ${widget.screenInfoVO.scale.value}')),
      Center(child: CustomPaint(size: _renderSize,
        painter: WiresConnectionsPainter(widget.blocks),
      ),),
      ...widget.blocks.map((b) => MovableBlock(b)).toList()
    ]);
  }
}

class WiresConnectionsPainter extends CustomPainter {
  final List<WireBlockVO> blocks;

  WiresConnectionsPainter(this.blocks):super();

  void _drawDot(Canvas canvas, Point<double> position, [color = Colors.red]) => canvas.drawCircle(
    Offset(position.x, position.y), 4, Paint()..color = color);

  @override
  void paint(Canvas canvas, Size size) {
    for (var wireBlockVO in blocks) {
      if (wireBlockVO.connections == null) return;
      final connectionPoints = wireBlockVO.connectionPoints;
      wireBlockVO.connections!.map((WireBlockVO c) {
        Point<double> pOne = connectionPoints[0];
        Point<double> pTwo = c.connectionPoints[0];
        double minDistance = double.infinity,
            testDistance = double.infinity;

        for (var p1 in connectionPoints) {
          for (var p2 in c.connectionPoints) {
            testDistance = p1.distanceTo(p2);
            if (testDistance < minDistance) {
              pOne = p1; pTwo = p2;
              minDistance = testDistance;
            }
          }
        }

        pOne = PositionUtils.utilSnapToGridPoint(pOne);
        pTwo = PositionUtils.utilSnapToGridPoint(pTwo);

        Offset pStart = Offset(pOne.x, pOne.y);
        Offset pEnd = Offset(pTwo.x, pTwo.y);

        canvas.drawPoints(PointMode.points, [ pStart, pEnd ], Paint()
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
    // _drawDot(canvas, center);
    // _drawDot(canvas, topLeft, Colors.pink);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return true;
  }
}
