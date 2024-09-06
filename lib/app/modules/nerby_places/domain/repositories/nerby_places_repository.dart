import 'package:dartz/dartz.dart';

import '../../../../core/shared/failures/failure.dart';
import '../entities/nerby_places.dart';
import '../entities/nerby_places_parameters.dart';

abstract class NerbyPlacesRepository {
  Future<Either<Failure, NerbyPlaces>> call(NerbyPlacesParameters parameters);
}
