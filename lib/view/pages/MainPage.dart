import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:wire_viewer/constants/StaticSettings.dart';
import 'package:wire_viewer/model/vos/WireContextVO.dart';

import '../components/BackgroundGridWidget.dart';
import '../components/DraggableWidget.dart';
import '../components/painter/WiresPainterWidget.dart';

generatePointOffset() {
  double xPos = Random().nextDouble() * ui.window.physicalSize.width;
  double yPos = Random().nextDouble() * ui.window.physicalSize.height;
  print('> generatePointOffset: $xPos:$yPos');
  return Offset(xPos, yPos);
}

final CENTER_POINT =
    Point(ui.window.physicalSize.width / 2, ui.window.physicalSize.height / 2);

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static get screenWidth => ui.window.physicalSize.width;
  static get screenHeight => ui.window.physicalSize.height;

  // https://github.com/dragonman225/curved-arrows
  final wireContextVO = WireContextVO(
    MutableRectangle(CENTER_POINT.x, CENTER_POINT.y, 100, 100),
    [
      const Point(100, 100),
      Point(screenWidth - 100, 100),
      Point(screenWidth - 100, screenHeight - 100),
      Point(100, screenHeight - 100),
    ]);

  @override
  Widget build(BuildContext context) {
    final contextWidth = screenWidth * StaticSettings.CONTEXT_SCALE_MULTIPLIER;
    final contextHeight = screenHeight * StaticSettings.CONTEXT_SCALE_MULTIPLIER;
    final contextSize = Rectangle<double>(0, 0, contextWidth, contextHeight);
    print('> MainPage -> contextSize $contextSize');
    return Scaffold(
      appBar: AppBar(title: const Text('Wire Viewer Application')),
      body: InteractiveViewer(
        boundaryMargin: const EdgeInsets.all(StaticSettings.CONTEXT_BOUNDARY_MARGIN),
        minScale: 0.1,
        maxScale: StaticSettings.CONTEXT_SCALE_MULTIPLIER,
        clipBehavior: Clip.hardEdge,
        panEnabled: true,
        constrained: false,
        child: Stack(
          children: [
            BackgroundGridWidget(contextSize),
            ConnectionsPainterWidget(wireContextVO),
            DraggableWidget(wireContextVO),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
