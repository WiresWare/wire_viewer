import 'dart:math';

import 'package:flutter/cupertino.dart';

class WireContextVO {
  final MutableRectangle<double> block;
  final List<Point<double>> connections;

  late final ValueNotifier<Point<double>> position;

  WireContextVO(this.block, this.connections) {
    position = ValueNotifier<Point<double>>(block.topLeft);
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
