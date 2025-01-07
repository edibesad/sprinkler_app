import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';

class WebSocketService {
  WebSocketService._init();
  static WebSocketService? _instance;

  static WebSocketService get instance {
    _instance ??= WebSocketService._init();
    return _instance!;
  }

  WebSocket? _socket;
  final StreamController<String> _messageController =
      StreamController<String>.broadcast();

  Stream<String> get getMessages => _messageController.stream;

  Future<void> connectToSocket(String host) async {
    try {
      _socket = await WebSocket.connect(
        host,
      );

      _socket!.listen(_onMessage, onDone: _onDone, onError: _onError);
    } catch (e) {
      if (kDebugMode) {
        throw "Hata Kodu: WSSCTS. Hata $e";
      }
    }
  }

  void _onMessage(dynamic message) {
    if (message is Uint8List) {
      _messageController.add(String.fromCharCodes(message));
    } else if (message is String) {
      _messageController.add(message);
    }
  }

  void _onDone() {
    if (kDebugMode) {
      print('WebSocket bağlantısı kapatıldı.');
    }
  }

  void _onError(dynamic error) {
    if (kDebugMode) {
      print('WebSocket hatası: $error');
    }
  }

  // Bağlantıyı kapatma
  void disconnect() {
    _socket?.close();
    _socket = null;
  }

  // Mesaj gönderme
  void sendMessage(String message) {
    _socket?.add(message);
  }
}
