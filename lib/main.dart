import 'package:doxa/logic/bluetooth_service.dart';
// import 'package:doxa/pages/_dash_/classifier.dart';
import 'package:doxa/pages/aintro_splash.dart';
// import 'package:doxa/pages/asplash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await loadResources();
  runApp(ChangeNotifierProvider(
    create: (context) => BluetoothService(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'DoxA',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
          useMaterial3: true,
        ),
        home: IntroSplash());
  }
}
