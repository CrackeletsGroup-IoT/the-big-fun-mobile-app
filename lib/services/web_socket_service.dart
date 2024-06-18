import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  final WebSocketChannel channel;

  WebSocketService(String url)
      : channel = IOWebSocketChannel.connect(url);

  Stream get stream => channel.stream;

  void dispose() {
    channel.sink.close();
  }
}