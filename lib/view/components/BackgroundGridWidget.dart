import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:wire_viewer/constants/StaticSettings.dart';

class BackgroundGridWidget extends StatelessWidget {
  const BackgroundGridWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridPaper(
        interval: StaticSettings.GRID_SIZE,
        divisions: 1,
        subdivisions: 1,
        color: StaticSettings.GRID_COLOR,
        child: SizedBox(
          width: ui.window.physicalSize.width,
          height: ui.window.physicalSize.height,
        ));
  }
}
