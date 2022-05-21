import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:wire_viewer/constants/StaticSettings.dart';
import 'package:wire_viewer/model/vos/screen_info_vo.dart';
import 'package:wire_viewer/model/vos/wire_block_vo.dart';
import 'package:wire_viewer/view/components/layers/layer_background.dart';
import 'package:wire_viewer/view/components/layers/layer_wire_blocks.dart';

generatePointOffset() {
  double xPos = Random().nextDouble() * ui.window.physicalSize.width;
  double yPos = Random().nextDouble() * ui.window.physicalSize.height;
  print('> generatePointOffset: $xPos:$yPos');
  return Offset(xPos, yPos);
}

final CENTER_POINT = Point(ui.window.physicalSize.width / 2, ui.window.physicalSize.height / 2);

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static get screenWidth => ui.window.physicalSize.width;
  static get screenHeight => ui.window.physicalSize.height;

  TransformationController _transformationController =
    TransformationController();

  final wireBlocks = [
    WireBlockVO.fromPosition(CENTER_POINT),
    WireBlockVO.fromPosition(Point(CENTER_POINT.x, CENTER_POINT.y - 200)),
    WireBlockVO.fromPosition(const Point<double>(100, 100)),
    WireBlockVO.fromPosition(Point(screenWidth - 100, 100)),
    WireBlockVO.fromPosition(Point(screenWidth - 100, screenHeight - 100)),
    WireBlockVO.fromPosition(Point(100, screenHeight - 100)),
  ];

  @override
  void initState() {
    super.initState();
    final connections = wireBlocks.getRange(2, wireBlocks.length).toList();
    wireBlocks[0].connections = connections;
  }

  // https://github.com/dragonman225/curved-arrows

  @override
  Widget build(BuildContext context) {
    final contextWidth = screenWidth * StaticSettings.CONTEXT_SCALE_MULTIPLIER;
    final contextHeight = screenHeight * StaticSettings.CONTEXT_SCALE_MULTIPLIER;

    final screenInfoVO = ScreenInfoVO(Size(contextWidth, contextHeight));

    print('> MainPage -> contextSize ${screenInfoVO.size}');

    return Scaffold(
      appBar: AppBar(title: const Text('Wire Viewer Application')),
      body: InteractiveViewer(
        transformationController: _transformationController,
        boundaryMargin: const EdgeInsets.all(StaticSettings.CONTEXT_BOUNDARY_MARGIN),
        onInteractionUpdate: (updateDetails) {
          double correctScaleValue = _transformationController.value.getMaxScaleOnAxis();
          if (screenInfoVO.scale.value != correctScaleValue) {
            wireBlocks.forEach((block) { block.scale = correctScaleValue; });
            screenInfoVO.scale.value = correctScaleValue;
            print('Interaction Update -'
                ' Scale: ${correctScaleValue.toString()}'
            );
          }
        },
        minScale: 0.1,
        maxScale: StaticSettings.CONTEXT_SCALE_MULTIPLIER,
        clipBehavior: Clip.hardEdge,
        panEnabled: true,
        constrained: false,
        child: Stack(
          children: <Widget>[
            BackgroundLayer(screenInfoVO.size.value),
            ValueListenableBuilder(valueListenable: screenInfoVO.scale, builder: (_, __, ___) =>
              WireBlocksLayer(wireBlocks, screenInfoVO)),
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Tools',
        backgroundColor: Colors.white,
        child: const Icon(Icons.adjust),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
