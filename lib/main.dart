import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taghyeer_task/presentation/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock the app orientation to portrait mode \\
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);


  await initHive();

  runApp(const App());
}

// Initialize Hive for local storage \\
Future<void> initHive() async {
  await Hive.initFlutter();
}