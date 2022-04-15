import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wire_viewer/model/vos/WireBlockVO.dart';
import 'package:wire_viewer/view/components/movable/movable_block.dart';

import 'painter/wires_painter.dart';

class WireBlockWidget extends StatefulWidget {
  final WireBlockVO wireBlockVO;

  const WireBlockWidget(this.wireBlockVO, {Key? key}) : super(key: key);

  @override
  _WireBlockWidgetState createState() => _WireBlockWidgetState();
}

class _WireBlockWidgetState extends State<WireBlockWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final wireBlockVO = widget.wireBlockVO;
    final connections = wireBlockVO.connections;
    print('> WireBlockWidget -> build: has ${connections?.length} connections');
    return connections != null ? Stack(
      children: [
        WiresPainter(wireBlockVO),
        MovableBlock(wireBlockVO),
      ],
    ) : MovableBlock(wireBlockVO);
  }
}
