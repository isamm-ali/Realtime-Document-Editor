import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketClient {
  io.Socket? socket;

  static SocketClient? _instance;

  static String get host {
    if (kIsWeb) {
      return 'http://localhost:5000';
    }

    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:5000';
    }

    return 'http://localhost:5000';
  }

  SocketClient._internal() {
    socket = io.io(host, <String, dynamic>{
      'autoConnect': false,
      'transports': ['polling', 'websocket'],
    });

    socket!.onConnect((_) {
      debugPrint('SOCKET CONNECTED: ${socket!.id}');
    });

    socket!.onDisconnect((reason) {
      debugPrint('SOCKET DISCONNECTED: $reason');
    });

    socket!.onConnectError((error) {
      debugPrint('SOCKET CONNECT ERROR: $error');
    });

    socket!.onError((error) {
      debugPrint('SOCKET ERROR: $error');
    });

    socket!.onReconnectAttempt((attempt) {
      debugPrint('SOCKET RECONNECT ATTEMPT: $attempt');
    });

    socket!.connect();
  }

  static SocketClient get instance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }
}
