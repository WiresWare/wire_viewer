import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:wire_viewer/model/vos/ConnectionVO.dart';
import 'package:wire_viewer/model/vos/WireContextVO.dart';

import '../components/DraggableWidget.dart';
import '../components/painter/CurvePainterWidget.dart';

generatePointOffset() {
  double xPos = Random().nextDouble() * ui.window.physicalSize.width;
  double yPos = Random().nextDouble() * ui.window.physicalSize.height;
  print('> generatePointOffset: $xPos:$yPos');
  return Offset(xPos, yPos);
}

final CENTER_POINT = Point(
  ui.window.physicalSize.width / 2,
  ui.window.physicalSize.height / 2
);

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final wireContextVO = WireContextVO(
    MutableRectangle(CENTER_POINT.x, CENTER_POINT.y, 100, 100),
    [
      const Point(100, 100),
      Point(ui.window.physicalSize.width - 100, 100),
      Point(ui.window.physicalSize.width - 100, ui.window.physicalSize.height - 100),
      Point(100, ui.window.physicalSize.height - 100),
    ]);
  final List<ConnectionVO> connections = [
    ConnectionVO(CENTER_POINT, const Point(100, 100)),
    ConnectionVO(CENTER_POINT, Point(ui.window.physicalSize.width - 100, 100)),
    ConnectionVO(CENTER_POINT, Point(ui.window.physicalSize.width - 100, ui.window.physicalSize.height - 100)),
    ConnectionVO(CENTER_POINT, Point(100, ui.window.physicalSize.height - 100)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wire Viewer Application')),
      body: Stack(
        children: [
          CurvePainterWidget(connections),
          DraggableWidget(wireContextVO),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
