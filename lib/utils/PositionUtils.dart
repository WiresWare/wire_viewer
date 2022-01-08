import 'dart:math';

import 'package:wire_viewer/constants/StaticSettings.dart';

class PositionUtils {
  static double snapToGrid(value) { return (value / StaticSettings.GRID_SIZE as double).ceil() * StaticSettings.GRID_SIZE; }
  static Point<double> snapToGridPoint(Point<double> value) { return Point<double>(snapToGrid(value.x), snapToGrid(value.y)); }
}