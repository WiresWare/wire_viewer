import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wire_viewer/components/DraggableWidget.dart';
import 'package:wire_viewer/components/painter/PointsPainterWidget.dart';

import '../components/painter/CurvePainterWidget.dart';

generatePointOffset() {
  return Offset(Random().nextDouble() * window.physicalSize.width, Random().nextDouble() * window.physicalSize.height);
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Offset> points = [generatePointOffset(), generatePointOffset()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wire Viewer Application')),
      body: Stack(
        children: [
          CurvePainterWidget(points),
          PathPainterWidget(points),
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
