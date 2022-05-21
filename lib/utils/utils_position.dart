import 'dart:math';

import 'package:wire_viewer/constants/StaticSettings.dart';

class PositionUtils {
  static double utilSnapToGrid(value) { return (value / StaticSettings.GRID_SIZE as double).ceil() * StaticSettings.GRID_SIZE; }
  static Point<double> utilSnapToGridPoint(Point<double> value) { return Point<double>(utilSnapToGrid(value.x), utilSnapToGrid(value.y)); }
}