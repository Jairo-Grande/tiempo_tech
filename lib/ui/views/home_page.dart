import 'package:flutter/material.dart';
import 'package:tiempo_tech/data/datasource/remote_datasource.dart';
import 'package:tiempo_tech/data/repositories/nasa_repository_impl.dart';
import 'package:tiempo_tech/dependency_injection/injection.dart';
import 'package:tiempo_tech/domain/use_cases/get_nasa_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
/*     repositoryImpl.get('query'); */

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: ElevatedButton(
            onPressed: () async {
              final GetNasaApi _getMarvelApi = GetNasaApi(locator());

              final response =
                  await _getMarvelApi.getNasaResult(query: 'query');
            },
            child: Text('request')),
      ),
    );
  }
}
