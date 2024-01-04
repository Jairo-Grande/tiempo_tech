import 'package:flutter/material.dart';
import 'package:tiempo_tech/app.dart';
import 'dependency_injection/injection.dart' as dependencyInjection;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  dependencyInjection.init();
  runApp(const MainApp());
}
