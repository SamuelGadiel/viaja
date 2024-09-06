import 'package:dartz/dartz.dart';

import '../../../../core/shared/failures/failure.dart';
import '../entities/nerby_places.dart';
import '../entities/nerby_places_parameters.dart';
import '../repositories/nerby_places_repository.dart';

abstract class GetNerbyPlaces {
  Future<Either<Failure, NerbyPlaces>> call(NerbyPlacesParameters parameters);
}

class GetNerbyPlacesImplementation implements GetNerbyPlaces {
  final NerbyPlacesRepository repository;

  GetNerbyPlacesImplementation(this.repository);

  @override
  Future<Either<Failure, NerbyPlaces>> call(NerbyPlacesParameters parameters) async {
    return repository(parameters);
  }
}
