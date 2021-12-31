import 'dart:math';

class WireContextVO {
  final MutableRectangle<double> block;
  final List<Point> connections;
  WireContextVO(this.block, this.connections);

  get centerX => block.left - block.width / 2;
  get centerY => block.top - block.height / 2;
  set offsetX(value) => block.left += value;
  set offsetY(value) => block.top += value;
}
