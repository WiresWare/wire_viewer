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

  final _backgroundColor = Colors.lightGreen;
  final _backgroundColorSelected = Colors.green;

  double _localMouseX = 0.0;
  double _localMouseY = 0.0;

  bool _isHover = false;
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
  }

  void _onUpdatePosition(Offset offset) {
    setState(() { widget.wireContextVO.offset = offset; });
  }

  void _onMouseHover(PointerEvent pointerEvent) {
    _localMouseX = pointerEvent.localPosition.dx;
    _localMouseY = pointerEvent.localPosition.dy;
    // print('> MovableBlock -> _onMouseHover: x|y = ${_innerMouseX} | ${_innerMouseY}');
  }

  void _onClick() {
    print('> MovableBlock -> _onMouseHover: x|y = ${_localMouseX} | ${_localMouseY}');
    _isSelected = !_isSelected;
  }

  double get scale => widget.wireContextVO.scale;

  @override
  Widget build(BuildContext context) {
    // const ts = TextStyle(fontSize: 16);
    return Positioned(
      left: PositionUtils.utilSnapToGrid(widget.wireContextVO.x),
      top: PositionUtils.utilSnapToGrid(widget.wireContextVO.y),
      child: Draggable(
        child: StatefulBuilder(builder: (_, update) => MouseRegion(
            onEnter: (_) => update(() { _isHover = true; }),
            onExit:  (_) => update(() { _isHover = false; }),
            onHover: _onMouseHover,
            child: GestureDetector(
              onTap: () => update(_onClick),
              child: Container(
                width: widget.wireContextVO.block.width,
                height: widget.wireContextVO.block.height,
                decoration: _buildDecoration(),
                // child: const Center(child: Text("Drag Me", style: ts,)),
              ),
            ),
          ),
        ),
        feedback: Container(),
        onDragUpdate: (DragUpdateDetails details) {
          _onUpdatePosition(details.delta);
        },
        onDragStarted: () {
          print("> MovableBlock -> onDragStarted: inner offset x|y = ${_localMouseX}|${widget.wireContextVO.centerX} - w|h = ${widget.wireContextVO.width}|${widget.wireContextVO.height}");
        },
        onDraggableCanceled: (Velocity velocity, Offset offset) {
          print("> MovableBlock -> onDragEnd: ${offset.toString()}");
        },
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      color: _isSelected ? _backgroundColorSelected : _backgroundColor,
      border: _isHover ? Border.all(
        width: 2,
        color: Colors.red
      ) : null,
    );
  }
}
