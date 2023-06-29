import 'package:dartz/dartz.dart';

import '../../../../core/shared/failures/failure.dart';
import '../entities/place_image.dart';
import '../entities/place_image_parameters.dart';
import '../repositories/place_image_repository.dart';

abstract class GetPlaceImage {
  Future<Either<Failure, PlaceImage>> call(PlaceImageParameters parameters);
}

class GetPlaceImageImplementation implements GetPlaceImage {
  final PlaceImageRepository repository;

  GetPlaceImageImplementation(this.repository);

  @override
  Future<Either<Failure, PlaceImage>> call(PlaceImageParameters parameters) async {
    return repository(parameters);
  }
}
