import 'dart:math';

import 'package:flutter/cupertino.dart';

class WireBlockVO {
  final MutableRectangle<double> block;
  List<WireBlockVO>? connections;
  List<Point<double>> connectionPoints = [];

  _calculateConnectionPoints() {
    connectionPoints = [
      Point<double>(block.left + block.width / 2,   block.top), // TOP
      Point<double>(block.left + block.width,       block.top + block.height / 2), // RIGHT
      Point<double>(block.left + block.width / 2,   block.bottom), // BOTTOM
      Point<double>(block.left,                     block.top + block.height / 2) // LEFT
    ];
  }

  WireBlockVO(this.block, { this.connections }) {
    _calculateConnectionPoints();
  }

  factory WireBlockVO.fromPosition(Point<double> position, { connections }) {
    return WireBlockVO(
      MutableRectangle<double>(
        position.x,
        position.y,
        160.0,
        120.0
      ),
      connections: connections);
  }

  get x => block.left;
  get y => block.top;

  get top => y;
  get bottom => y + block.height;
  get left => x;
  get right => x + block.width;

  set offset(Offset value) {
    block.left += value.dx;
    block.top += value.dy;
    _calculateConnectionPoints();
  }
}
