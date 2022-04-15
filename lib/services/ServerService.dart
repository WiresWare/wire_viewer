import 'dart:core';
import 'dart:async';
import 'dart:io';

import 'package:wire_viewer/services/IConnectionService.dart';
import 'dart:typed_data';

class ServerService implements IConnectionService {
  final Stream<dynamic> _dataStream = const Stream.empty();

  ServerService() {
    Future<ServerSocket> serverFuture = ServerSocket.bind('0.0.0.0', 55555);
    serverFuture.then((ServerSocket server) {
      server.listen((Socket socket) {
        socket.listen((List<int> data) {
          String result = String.fromCharCodes(data);
          print(result.substring(0, result.length - 1));
        });
      });
    });
  }

  @override
  Future<void> init(int port) async {
    final server = await ServerSocket.bind(InternetAddress.anyIPv4, port);
    server.listen((Socket client) {
      client.listen(
        _onMessage,
        onError: _onError,
        onDone: _onDone
      );
    });

  }

  void _onMessage(Uint8List data) async {
    final result = String.fromCharCodes(data);
    // _dataStream.
  }

  void _onError(error) async {
    print('Client left ${error.toString()}');
  }

  void _onDone () {
    print('Client left');
  }

  @override
  Stream get change => throw UnimplementedError();
}