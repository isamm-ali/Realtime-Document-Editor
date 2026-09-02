import 'package:frontend/clients/socket_client.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketRepository {
  final Socket _socket = SocketClient.instance.socket!;
  Socket get socket => _socket;

  void joinRoom(String documentId) {
    _socket.emit('join', documentId);
  }

  void typing(Map<String, dynamic> data) {
    _socket.emit('typing', data);
  }

  void autoSave(Map<String, dynamic> data) {
    _socket.emit('save', data);
  }

  void changeListener(Function(Map<String, dynamic>) func) {
    _socket.on('changes', (data) => func(data));
  }
}
