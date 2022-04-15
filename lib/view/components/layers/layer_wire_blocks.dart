import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wire_viewer/constants/StaticSettings.dart';
import 'package:wire_viewer/view/components/wire_block.dart';

import '../../../model/vos/WireBlockVO.dart';

class WireBlocksLayer extends StatefulWidget {
  const WireBlocksLayer(this.blocks, this.contextSize, { Key? key }) : super(key: key);

  final List<WireBlockVO> blocks;
  final Rectangle contextSize;

  @override
  State<WireBlocksLayer> createState() => _WireBlocksLayerState();
}

class _WireBlocksLayerState extends State<WireBlocksLayer> with WidgetsBindingObserver {
  late Size _screenSize;

  @override
  void initState() {
    super.initState();
    _screenSize = WidgetsBinding.instance!.window.physicalSize;
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    setState(() { _screenSize = WidgetsBinding.instance!.window.physicalSize; });
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: [
        Positioned(top: 8, left: 16,
          child: Text('Screen size: ${_screenSize.toString()}')),
        ...widget.blocks.map((block) =>
            WireBlockWidget(block)).toList()
      ]));
  }
}
