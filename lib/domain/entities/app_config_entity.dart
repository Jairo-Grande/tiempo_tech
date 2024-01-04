class AppConfig {
  AppConfig({
    required this.baseUrl,
    required this.connectTimeOut,
    required this.receiveTimeOut,
  });

  final String baseUrl;
  final int connectTimeOut;
  final int receiveTimeOut;
}
