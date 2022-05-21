import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wire_viewer/model/vos/wire_block_vo.dart';
import 'package:wire_viewer/utils/utils_position.dart';

class MovableBlock extends StatefulWidget {
  const MovableBlock(this.wireContextVO, {Key? key}) : super(key: key);

  final WireBlockVO wireContextVO;

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
    // const ts = TextStyle(fontSize: 16);
    return Positioned(
      left: PositionUtils.utilSnapToGrid(widget.wireContextVO.x),
      top: PositionUtils.utilSnapToGrid(widget.wireContextVO.y),
      child: Draggable(
        child: Container(
          width: widget.wireContextVO.block.width,
          height: widget.wireContextVO.block.height,
          color: Colors.lightGreen.withOpacity(0.3),
          // child: const Center(child: Text("Drag Me", style: ts,)),
        ),
        feedback: Container(
          width: widget.wireContextVO.width,
          height: widget.wireContextVO.height,
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
