import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class BluetoothService with ChangeNotifier {
  static final BluetoothService _instance = BluetoothService._internal();
  factory BluetoothService() => _instance;
  BluetoothService._internal();

  BluetoothConnection? _connection;
  bool _isConnected = false;

  bool get isConnected => _isConnected;

  void setConnection(BluetoothConnection conn) {
    _connection = conn;
    _isConnected = true;
    notifyListeners();

    // ✅ Listen for disconnection events in real-time
    _connection!.input!.listen((_) {}).onDone(() {
      _handleDisconnect();
    });
  }

  void _handleDisconnect() {
    _isConnected = false;
    _connection = null;
    notifyListeners(); // ✅ Updates UI when disconnected
    print("Bluetooth Disconnected");
  }

  void disconnect() async {
    if (_connection != null && _connection!.isConnected) {
      await Future.delayed(Duration(milliseconds: 200)); // Wait a bit
    _connection!.finish();  // Close connection properly
  }
  _handleDisconnect(); // ✅ Handle cleanup
  }

  void sendCommand(String command) {
    if (_connection != null && _connection!.isConnected) {
      _connection!.output.add(Uint8List.fromList(command.codeUnits));
      _connection!.output.allSent.then((_) {
        print("Command '$command' sent");
      });
    } else {
      print("Bluetooth not connected");
    }
  }
}
