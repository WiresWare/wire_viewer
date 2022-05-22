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

  double _scale = 1.0;

  late double width = block.width;
  late double height = block.height;

  double get scale => _scale;

  set scale(double value) {
    _scale = value;
    width = block.width * value;
    height = block.height * value;
  }

  get x => block.left;
  get y => block.top;

  get centerX => block.width / 2;
  get centerY => block.height / 2;

  get top => y;
  get bottom => y + height;
  get left => x;
  get right => x + width;

  set offset(Offset value) {
    block.left += value.dx / _scale;
    block.top += value.dy / _scale;
    _calculateConnectionPoints();
  }
}
