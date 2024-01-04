import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:tiempo_tech/data/datasource/remote_datasource.dart';
import 'package:tiempo_tech/data/model/app_config_model.dart';
import 'package:tiempo_tech/data/repositories/nasa_repository_impl.dart';
import 'package:tiempo_tech/domain/entities/app_config_entity.dart';
import 'package:tiempo_tech/domain/repositories/nasa_repository.dart';
import 'package:yaml/yaml.dart';

final locator = GetIt.instance;

Future<void> init() async {
  final configFile = await rootBundle.loadString('lib/config/app_config.yaml');
  final YamlMap yamlMap = loadYaml(configFile);
  late AppConfig appConfig = AppConfigModel.fromMap(yamlMap);

//repository
  locator.registerLazySingleton<NasaRepository>(
    () => NasaRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<RemoteDataSource>(() => RemoteDataSource(
        baseUrl: appConfig.baseUrl,
        connectTimeout: appConfig.connectTimeOut,
        receiveTimeOut: appConfig.receiveTimeOut,
      ));
}
