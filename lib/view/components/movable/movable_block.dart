import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wire_viewer/model/vos/WireBlockVO.dart';
import 'package:wire_viewer/utils/PositionUtils.dart';

class MovableBlock extends StatefulWidget {
  final WireBlockVO wireContextVO;

  const MovableBlock(this.wireContextVO, {Key? key}) : super(key: key);

  @override
  _MovableBlockState createState() => _MovableBlockState();
}

class _MovableBlockState extends State<MovableBlock> {
  @override
  void initState() {
    super.initState();
  }

  void _updatePosition(Offset offset) {
    setState(() { widget.wireContextVO.offset = offset; });
  }

  @override
  Widget build(BuildContext context) {
    const ts = TextStyle(fontSize: 16);
    double
      width = widget.wireContextVO.block.width,
      height = widget.wireContextVO.block.height;

    return Positioned(
      left: PositionUtils.snapToGrid(widget.wireContextVO.x),
      top: PositionUtils.snapToGrid(widget.wireContextVO.y),
      child: Draggable(
        child: Container(width: width, height: height,
          color: Colors.lightGreen.withOpacity(0.3),
          // child: const Center(child: Text("Drag Me", style: ts,)),
        ),
        feedbackOffset: const Offset(0, 100),
        feedback: Container(width: width, height: height,
          color: Colors.green.withOpacity(0.3),
        ),
        onDragUpdate: (DragUpdateDetails details) {
          _updatePosition(details.delta);
        },
        onDragStarted: () {
          print("onDragStarted NOT: ${widget.wireContextVO.block.toString()}");
        },
        onDraggableCanceled: (Velocity velocity, Offset offset) {
          print("onDragEnd NOT: ${offset.toString()}");
        },
      ),
    );
  }
}