import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothManager extends ChangeNotifier {
  static final BluetoothManager _instance = BluetoothManager._internal();
  factory BluetoothManager() => _instance;

  BluetoothManager._internal();

  BluetoothDevice? _selectedDevice;
  BluetoothConnection? _connection;
  bool _isConnecting = false;

  BluetoothDevice? get selectedDevice => _selectedDevice;
  bool get isConnected => _connection != null && _connection!.isConnected;
  bool get isConnecting => _isConnecting;

  Future<void> connectToDevice(BluetoothDevice device) async {
    _selectedDevice = device;
    _isConnecting = true;
    notifyListeners(); // 🔹 Update UI when connecting

    try {
      _connection = await BluetoothConnection.toAddress(device.address);
      if (_connection != null && _connection!.isConnected) {
        notifyListeners(); // 🔹 Notify UI about successful connection
      }
    } catch (e) {
      print("Connection failed: $e");
      _selectedDevice = null;
    }

    _isConnecting = false;
    notifyListeners(); // 🔹 Update UI after attempt
  }

  Future<void> disconnect() async {
    if (_connection != null) {
      await _connection!.close();
      _connection = null;
      _selectedDevice = null;
      notifyListeners(); // 🔹 Notify UI about disconnection
    }
  }
}