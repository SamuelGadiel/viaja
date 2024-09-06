import 'package:dartz/dartz.dart';

import '../../../../core/shared/failures/failure.dart';
import '../../domain/entities/nerby_places.dart';
import '../../domain/entities/nerby_places_parameters.dart';
import '../../domain/failures/nerby_places_failure.dart';
import '../../domain/repositories/nerby_places_repository.dart';
import '../datasources/nerby_places_datasource.dart';
import '../errors/nerby_places_error.dart';

class NerbyPlacesRepositoryImplementation implements NerbyPlacesRepository {
  final NerbyPlacesDatasource datasource;

  NerbyPlacesRepositoryImplementation(this.datasource);

  @override
  Future<Either<Failure, NerbyPlaces>> call(NerbyPlacesParameters parameters) async {
    try {
      return Right(await datasource(parameters));
    } on NerbyPlacesError catch (e) {
      return Left(NerbyPlacesFailure(message: e.message));
    } on Exception catch (e) {
      return Left(NerbyPlacesFailure(message: e.toString()));
    }
  }
}
