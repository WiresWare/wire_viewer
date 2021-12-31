import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' as render;

import '../../model/vos/WireContextVO.dart';

class DraggableWidget extends StatefulWidget {
  final WireContextVO contextVO;

  const DraggableWidget(this.contextVO, {Key? key}) : super(key: key);

  @override
  _DraggableWidgetState createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget> {
  @override
  void initState() {
    super.initState();
  }

  void _updatePosition(Offset offset) {
    setState(() { widget.contextVO.offset = offset; });
  }

  @override
  Widget build(BuildContext context) {
    const ts = TextStyle(fontSize: 16);
    double
      width = widget.contextVO.block.width,
      height = widget.contextVO.block.height;
    return Positioned(
      left: widget.contextVO.centerX,
      top: widget.contextVO.centerY,
      child: Draggable(
        child: Container(width: width, height: height,
          color: Colors.orangeAccent,
          child: const Center(child: Text("Drag Me", style: ts,)),
        ),
        feedbackOffset: const Offset(0, 100),
        feedback: Container(width: width, height: height,
          child: const Center(child: Text("Drag To", style: ts,)),
          color: Colors.green,
        ),
        onDragUpdate: (DragUpdateDetails details) {
          _updatePosition(details.delta);
        },
        onDragStarted: () {
          print("onDragStarted NOT: ${widget.contextVO.block.toString()}");
        },
        onDraggableCanceled: (Velocity velocity, Offset offset) {
          print("onDragEnd NOT: ${offset.toString()}");
          // final renderBox = context.findRenderObject() as render.RenderBox;
          // _updatePosition(renderBox.globalToLocal(offset));
        },
      ),
    );
  }
}
