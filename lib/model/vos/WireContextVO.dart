import 'dart:math';

import 'package:flutter/cupertino.dart';

const BLOCK_WIDTH = 140.0;
const BLOCK_HEIGHT = 90.0;

class WireContextVO {
  final MutableRectangle<double> block;
  List<WireContextVO>? connections;

  late final ValueNotifier<Point<double>> position;

  WireContextVO(this.block, { this.connections }) {
    position = ValueNotifier<Point<double>>(block.topLeft);
  }

  factory WireContextVO.fromPosition(Point<double> position, { connections }) {
    return WireContextVO(
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
  get left => x;
  get right => x + block.width;

  set offset(Offset value) {
    block.left += value.dx;
    block.top += value.dy;
    position.value = block.topLeft;
  }
}
