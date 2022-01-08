import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wire_viewer/constants/StaticSettings.dart';
import 'package:wire_viewer/view/components/WireBlockWidget.dart';

import '../../../model/vos/WireBlockVO.dart';

class WireBlocksLayerWidget extends StatelessWidget {
  final List<WireBlockVO> blocks;
  const WireBlocksLayerWidget(this.blocks, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: blocks.map((block) =>
        WireBlockWidget(block)).toList()));
  }
}
