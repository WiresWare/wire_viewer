import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' as render;
import 'package:wire_viewer/utils/PositionUtils.dart';

import '../../../model/vos/WireBlockVO.dart';
import 'movable/MovableBlockWidget.dart';
import 'painter/WiresPainterWidget.dart';

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
        WiresPainterWidget(wireBlockVO),
        MovableBlockWidget(wireBlockVO),
      ],
    ) : MovableBlockWidget(wireBlockVO);
  }
}
