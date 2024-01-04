import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:tiempo_tech/data/failure.dart';
import 'package:tiempo_tech/data/model/nasa_result_model.dart';
import 'package:tiempo_tech/domain/repositories/nasa_repository.dart';

class GetNasaApi {
  final NasaRepository repository;

  GetNasaApi(this.repository);

  Future<Either<Failure, NasaResult>> getNasaResult({required String query}) {
    return repository.getNasaResult(query: query);
  }
}
