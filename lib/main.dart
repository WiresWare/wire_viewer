import 'package:flutter/material.dart';
import 'package:wire/wire.dart';

import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'constants/assets/Fonts.dart';
import 'view/pages/main_page.dart';

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
        brightness: Brightness.light,
        primaryColor: Colors.blue[700],
        primarySwatch: Colors.grey,
        canvasColor: Colors.grey.shade300,
        appBarTheme: AppBarTheme(backgroundColor: Colors.grey.shade100, elevation: 1)),
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
