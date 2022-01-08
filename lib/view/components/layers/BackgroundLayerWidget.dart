import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wire_viewer/constants/StaticSettings.dart';

class BackgroundLayerWidget extends StatelessWidget {
  final Rectangle<double> size;
  const BackgroundLayerWidget(this.size, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridPaper(
        interval: StaticSettings.GRID_SIZE,
        divisions: 1,
        subdivisions: 1,
        color: StaticSettings.GRID_COLOR,
        child: SizedBox(
          width: size.width,
          height: size.height,
        ));
  }
}
