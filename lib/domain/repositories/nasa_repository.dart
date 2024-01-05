import 'package:either_dart/either.dart';

import 'package:tiempo_tech/data/failure.dart';
import 'package:tiempo_tech/data/model/nasa_result_model.dart';

abstract class NasaRepository {
  Future<Either<Failure, NasaData>> getNasaResult({String? query});
}
