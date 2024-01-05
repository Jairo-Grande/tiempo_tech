import 'package:flutter/material.dart';
import 'package:tiempo_tech/ui/views/details_page.dart';
import 'package:tiempo_tech/ui/views/favorites_page.dart';
import 'package:tiempo_tech/ui/views/home_page.dart';
import 'package:tiempo_tech/utils/constants.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  Routes.home: (_) => const HomePage(),
  Routes.details: (_) => const DetailsPage(),
  Routes.favorites: (_) => const FavoritesPage(),
};
