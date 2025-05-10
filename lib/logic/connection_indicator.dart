import 'package:doxa/pages/bluetooth_connect.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bluetooth_service.dart';

class ConnectionIndicator extends StatelessWidget {
  const ConnectionIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BluetoothService>(
        builder: (context, bluetoothService, child) {
      return IconButton(
        icon: Icon(
          bluetoothService.isConnected
              ? Icons.bluetooth_connected
              : Icons.bluetooth_disabled,
          color: bluetoothService.isConnected ? Colors.green : Colors.red,
          size: 45.5,
        ),
        onPressed: () {
          bluetoothService.isConnected
              ? ()
              : Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BluetoothConnect(),
                  ),
                );
        },
      );
    });
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       icon: Icon(
//         _bluetoothManager.isConnected
//             ? Icons.bluetooth_connected
//             : Icons.bluetooth_disabled,
//         color: _bluetoothManager.isConnected ? Colors.green : Colors.red,
//         size: 50,
//       ),
//       onPressed: () {
//         _bluetoothManager.isConnected
//             ? ()
//             : Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => BluetoothConnect(),
//                 ),
//               );
//       },
//     );
//   }
// }
