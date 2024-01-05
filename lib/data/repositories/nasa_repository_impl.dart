import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:tiempo_tech/data/datasource/remote/remote_datasource.dart';
import 'package:tiempo_tech/data/exception.dart';
import 'package:tiempo_tech/data/failure.dart';
import 'package:tiempo_tech/data/model/nasa_result_model.dart';
import 'package:tiempo_tech/domain/repositories/nasa_repository.dart';

class NasaRepositoryImpl implements NasaRepository {
  final RemoteDataSource remoteDataSource;

  NasaRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, NasaData>> getNasaResult({String? query}) async {
    try {
      final result = await remoteDataSource.getNasaResults(query: query);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
