import 'dart:core';

import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ViewerController {
  ViewerController() {
    var socket = WebSocketChannel.connect(Uri.parse('ws://localhost:4321'));
    var server = Server(socket.cast<String>());
    // Methods can take parameters. They're presented as a `Parameters` object
    // which makes it easy to validate that the expected parameters exist.
    server.registerMethod('echo', (Parameters params) {
      // If the request doesn't have a "message" parameter this will
      // automatically send a response notifying the client that the request
      // was invalid.
      return params['message'].value;
    });
    server.listen();
  }
}