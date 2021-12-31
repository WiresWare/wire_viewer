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
    const ts = TextStyle(fontSize: 16);
    return Positioned(
      left: widget.position.dx - width / 2,
      top: widget.position.dy - height / 2,
      child: Draggable(
        child: Container(
          width: width,
          height: height,
          color: Colors.orangeAccent.withOpacity(0.5),
          child: const Center(child: Text("Drag Me", style: ts,)),
        ),
        feedback: Container(
          width: width,
          height: height,
          child: const Center(child: Text("Drag To", style: ts,)),
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
