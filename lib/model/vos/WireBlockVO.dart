import 'dart:math';

import 'package:flutter/cupertino.dart';

const BLOCK_WIDTH = 140.0;
const BLOCK_HEIGHT = 100.0;

class WireBlockVO {
  final MutableRectangle<double> block;
  List<WireBlockVO>? connections;

  late final ValueNotifier<Point<double>> position;

  WireBlockVO(this.block, { this.connections }) {
    position = ValueNotifier<Point<double>>(block.topLeft);
  }

  factory WireBlockVO.fromPosition(Point<double> position, { connections }) {
    return WireBlockVO(
      MutableRectangle<double>(
        position.x,
        position.y,
        BLOCK_WIDTH,
        BLOCK_HEIGHT
      ),
      connections: connections);
  }

  get x => block.left - block.width / 2;
  get y => block.top - block.height / 2;
  get top => y;
  get bottom => y + block.height;
  get left => x;
  get right => x + block.width;

  get topLeft => Point<double>(left, top);
  get bottomRight => Point<double>(right, bottom);

  set offset(Offset value) {
    block.left += value.dx;
    block.top += value.dy;
    position.value = block.topLeft;
  }
}
