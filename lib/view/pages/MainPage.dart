import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:wire_viewer/model/vos/ConnectionVO.dart';

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
  final List<ConnectionVO> connections = [
    ConnectionVO(CENTER_POINT, const Point(100, 100)),
    ConnectionVO(CENTER_POINT, Point(ui.window.physicalSize.width - 100, 100)),
    ConnectionVO(CENTER_POINT, Point(ui.window.physicalSize.width - 100, ui.window.physicalSize.height - 100)),
    ConnectionVO(CENTER_POINT, Point(100, ui.window.physicalSize.height - 100)),
  ];
  final List<Offset> points = [
    Offset(ui.window.physicalSize.width / 2, ui.window.physicalSize.height / 2),
    const Offset(100, 100),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wire Viewer Application')),
      body: Stack(
        children: [
          CurvePainterWidget(points, connections),
          ...points.map((position) => DraggableWidget(position)).toList(),
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
