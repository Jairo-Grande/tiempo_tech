import 'package:flutter/material.dart';
import 'package:tiempo_tech/utils/constants.dart';
import 'package:tiempo_tech/utils/routes.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tiempo-tech-api',
      debugShowCheckedModeBanner: false,
      routes: appRoutes,
      initialRoute: Routes.home,
    );
  }
}
