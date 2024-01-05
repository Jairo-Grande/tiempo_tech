import 'package:dio/dio.dart';
import 'package:tiempo_tech/data/model/nasa_result_model.dart';
import 'package:tiempo_tech/data/exception.dart';

class RemoteDataSource {
  late Dio _client;
  late BaseOptions optionsApi;

  RemoteDataSource({
    required String baseUrl,
    required int connectTimeout,
    required int receiveTimeOut,
  }) {
    optionsApi = BaseOptions(
        baseUrl: baseUrl,
        responseType: ResponseType.json,
        headers: {'Content-Type': 'application/json', 'accept': '*/*'});

    _client = Dio(optionsApi);
  }

  addInterceptor(Interceptor interceptor) {
    _client.interceptors.add(interceptor);

    _client.interceptors.add(InterceptorsWrapper(onError: (e, handler) {
      handler.resolve(
          e.response ?? Response(requestOptions: RequestOptions(path: '')));
    }, onRequest: (r, handler) {
      handler.next(r);
    }, onResponse: (r, handler) {
      handler.next(r);
    }));
  }

  Future<NasaData> getNasaResults({required String? query}) async {
    try {
      final Map<String, dynamic> queryParams = {'q': query ?? ''};
      final apiResponse = await _client
          .get(
        '/search',
        queryParameters: queryParams,
      )
          .catchError((error) {
        return error.response;
      });

      if (apiResponse.statusCode == 200) {
        return NasaData.fromJson(apiResponse.data);
      } else {
        throw ServerException();
      }
    } catch (error) {
      // Manejo de errores específicos de Dio o cualquier otro error
      throw ServerException();
    }
  }
}
