import 'package:flutter/material.dart';
import 'package:wire_viewer/constants/StaticSettings.dart';

class PositionUtils {
  static double snapToGrid(value) { return (value / StaticSettings.GRID_SIZE as double).ceil() * StaticSettings.GRID_SIZE; }
}