import 'package:flutter/material.dart';
import 'package:scaffold_custom/scaffold_custom.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  BarsUIController.instance.init(packageName: 'com.example.example');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      statusBarColor: Colors.amber,
      navigationBarColor: Colors.blue.shade100,
      scaffoldBackgroundColor: Colors.amber,
      immersiveMode: true,
      respectNotchInImmersive: true,
      body: Column(children: [Text('data')]),
    );
  }
}
