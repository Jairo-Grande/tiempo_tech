import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiempo_tech/app.dart';
import 'package:tiempo_tech/bloc/bloc/nasa_bloc.dart';
import 'package:tiempo_tech/bloc/favorite/favorites_bloc.dart';
import 'package:tiempo_tech/dependency_injection/injection.dart' as dep_iny;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep_iny.init();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => dep_iny.locator<FavoritesBloc>()),
    BlocProvider(create: (_) => dep_iny.locator<NasaBloc>()),
  ], child: const MainApp()));
}
