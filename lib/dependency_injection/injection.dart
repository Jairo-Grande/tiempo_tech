import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:tiempo_tech/bloc/bloc/nasa_bloc.dart';
import 'package:tiempo_tech/bloc/favorite/favorites_bloc.dart';
import 'package:tiempo_tech/data/datasource/local/app_database.dart';
import 'package:tiempo_tech/data/datasource/remote/remote_datasource.dart';
import 'package:tiempo_tech/data/model/app_config_model.dart';
import 'package:tiempo_tech/data/repositories/database_repository_impl.dart';
import 'package:tiempo_tech/data/repositories/nasa_repository_impl.dart';
import 'package:tiempo_tech/domain/entities/app_config_entity.dart';
import 'package:tiempo_tech/domain/repositories/database_repository.dart';
import 'package:tiempo_tech/domain/repositories/nasa_repository.dart';
import 'package:tiempo_tech/domain/use_cases/get_nasa_api.dart';
import 'package:yaml/yaml.dart';

final locator = GetIt.instance;

Future<void> init() async {
  final configFile = await rootBundle.loadString('lib/config/app_config.yaml');
  final YamlMap yamlMap = loadYaml(configFile);
  late AppConfig appConfig = AppConfigModel.fromMap(yamlMap);

  final db = await AppDatabase().getInstance();
  locator.registerSingleton<AppDatabase>(db!);

  //database
  locator.registerSingleton<DatabaseRepository>(
    DatabaseRepositoryImpl(locator<AppDatabase>()),
  );

  //Bloc
  locator.registerFactory<NasaBloc>(() => NasaBloc(locator()));
  locator.registerFactory<FavoritesBloc>(() => FavoritesBloc(locator()));

  //usecase
  locator.registerLazySingleton(() => GetNasaApi(locator()));

//repository
  locator.registerLazySingleton<NasaRepository>(
    () => NasaRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

//API CONFIGURATION
  locator.registerLazySingleton<RemoteDataSource>(() => RemoteDataSource(
        baseUrl: appConfig.baseUrl,
        connectTimeout: appConfig.connectTimeOut,
        receiveTimeOut: appConfig.receiveTimeOut,
      ));
}
