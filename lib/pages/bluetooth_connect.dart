import 'package:doxa/logic/bluetooth_service.dart';
import 'package:doxa/logic/connection_indicator.dart';
import 'package:doxa/pages/cmenu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import '../logic/bluetooth_manager.dart';

class BluetoothConnect extends StatefulWidget {
  const BluetoothConnect({super.key});

  @override
  _BluetoothConnectState createState() => _BluetoothConnectState();
}

class _BluetoothConnectState extends State<BluetoothConnect> {
  final BluetoothManager _bluetoothManager = BluetoothManager();
  List<BluetoothDevice> _devicesList = [];

  @override
  void initState() {
    super.initState();
    _getPairedDevices();
  }

  Future<void> _getPairedDevices() async {
    List<BluetoothDevice> devices =
        await FlutterBluetoothSerial.instance.getBondedDevices();
    setState(() {
      _devicesList = devices
          .where((device) =>
              device.name != null &&
              (device.name!.contains("HC-05") ||
                  device.name!.contains("HC-06")))
          .toList();
    });
  }

  void connectToDevice(BluetoothDevice device) async {
    try {
      var conn = await BluetoothConnection.toAddress(device.address);
      BluetoothService().setConnection(conn); // Store globally
      print("Connected to ${device.name}");

      // Navigate to MenuScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MenuScreen()),
      );
    } catch (e) {
      print("Connection failed: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool exitApp = await _showExitDialog(context);
        if (exitApp) {
          BluetoothService().disconnect(); //Disconnect BT
          SystemNavigator.pop(); // Closes app properly on Android
        }
        return false; // Prevents default back action
      },
      child: Scaffold(
        bottomSheet: Container(
          decoration: BoxDecoration(color: Colors.transparent),
          padding: EdgeInsets.symmetric(horizontal: 2, vertical: 25),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("Skip To Menu"),
            SizedBox(width: 15.3,),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MenuScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                // backgroundColor: ledon ? Colors.pink : Colors.grey,
                shape: CircleBorder(),
                padding: EdgeInsets.all(12), // Same size as Horn button
              ),
              child:
                  Image.asset('assets/images/bot.png', width: 40, height: 40),
            ),
          ]),
        ),
        appBar: AppBar(
          title: Text("Connect to Doxa Robot"),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            ConnectionIndicator(), // ✅ Now updates in real-time
            Expanded(
              child: ListView.builder(
                itemCount: _devicesList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_devicesList[index].name ?? "Unknown"),
                    subtitle: Text(_devicesList[index].address),
                    trailing:
                        _bluetoothManager.selectedDevice == _devicesList[index]
                            ? Icon(Icons.check, color: Colors.green)
                            : null,
                    onTap: () => connectToDevice(_devicesList[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool> _showExitDialog(BuildContext context) async {
  return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Exit App'),
          content: Text('Are you sure you want to exit?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // Stay in app
              child: Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), // Exit app
              child: Text('Yes'),
            ),
          ],
        ),
      ) ??
      false; // Return false if the dialog is dismissed
}
