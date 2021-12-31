import 'dart:ui';

import 'package:flutter/material.dart';

class DraggableWidget extends StatefulWidget {
  final Offset position;

  const DraggableWidget(this.position, {Key? key}) : super(key: key);

  @override
  _DraggableWidgetState createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget> {
  double width = 100.0, height = 100.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.position.dx - width,
      top: widget.position.dy - height,
      child: Draggable(
        child: Container(
          width: width,
          height: height,
          color: Colors.orangeAccent,
          child: const Center(child: Text("Drag Me")),
        ),
        feedback: Container(
          width: width,
          height: height,
          child: const Center(child: Text("Drag To")),
          color: Colors.green,
        ),
        onDragStarted: () {
          print("onDragStarted");
        },
        onDragCompleted: () {
          print("onDragCompleted");
        },
        onDraggableCanceled: (Velocity velocity, Offset offset) {
          print("onDraggableCanceled");
          setState(() => {widget.position.translate(offset.dx, offset.dy)});
        },
      ),
    );
  }
}
