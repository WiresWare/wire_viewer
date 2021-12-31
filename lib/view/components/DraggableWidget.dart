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
          color: Colors.orangeAccent.withOpacity(0.5),
          child: const Center(child: Text("Drag Me", style: ts,)),
        ),
        feedbackOffset: const Offset(0, 100),
        feedback: Container(width: width, height: height,
          child: const Center(child: Text("Drag To", style: ts,)),
          color: Colors.green,
        ),
        onDragStarted: () {
          print("onDragStarted NOT: ${widget.contextVO.block.toString()}");
        },
        onDraggableCanceled: (Velocity velocity, Offset offset) {
          print("onDragEnd NOT: ${offset.toString()}");
          final renderBox = context.findRenderObject() as render.RenderBox;
          final Offset shift = renderBox.globalToLocal(offset);
          setState(() {
            widget.contextVO.offsetX = shift.dx;
            widget.contextVO.offsetY = shift.dy;
          });
        },
      ),
    );
  }
}
