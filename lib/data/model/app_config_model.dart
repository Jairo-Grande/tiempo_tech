import 'package:tiempo_tech/domain/entities/app_config_entity.dart';
import 'package:yaml/yaml.dart';

class AppConfigModel extends AppConfig {
  /// @param baseUrl - parte inicial de la url del servicio que se va a consumir
  /// @param connectTimeOut - Tiempo que la aplicación esperará para que se conecte con el servidor
  /// @param receiveTimeOut - Tiempo limite que la aplicación esperará una respuesta del servidor
  AppConfigModel({
    required super.baseUrl,
    required super.connectTimeOut,
    required super.receiveTimeOut,
  });

  factory AppConfigModel.fromMap(YamlMap json) => AppConfigModel(
      baseUrl: json["baseUrl"],
      connectTimeOut: json["connectTimeOut"],
      receiveTimeOut: json["receiveTimeOut"]);
}
