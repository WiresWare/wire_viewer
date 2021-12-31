import 'dart:math';

import 'package:flutter/cupertino.dart';

class WireContextVO {
  final MutableRectangle<double> block;
  final List<Point<double>> connections;

  late final ValueNotifier<Point<double>> position;

  WireContextVO(this.block, this.connections) {
    position = ValueNotifier<Point<double>>(block.topLeft);
  }

  get centerX => block.left - block.width / 2;
  get centerY => block.top - block.height / 2;

  set offset(Offset value) {
    block.left += value.dx;
    block.top += value.dy;
    position.value = block.topLeft;
  }
}
