import 'package:flutter/material.dart';

import 'constants/Fonts.dart';
import 'pages/MainPage.dart';

void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wire Viewer',
      theme: ThemeData(
        fontFamily: Fonts.SOURCE_SANS,
        brightness: Brightness.dark,
        primarySwatch: Colors.grey,
      ),
      home: const MainPage(),
    );
  }
}
