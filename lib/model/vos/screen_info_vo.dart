import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ScreenInfoVO {
  final ValueNotifier<Size> size = ValueNotifier(const Size(0, 0));
  final ValueNotifier<double> scale = ValueNotifier(1.0);

  ScreenInfoVO(Size size) {
    this.size.value = size;
  }
}
