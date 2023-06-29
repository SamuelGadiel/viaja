import 'package:dartz/dartz.dart';

import '../../../../core/shared/failures/failure.dart';
import '../entities/place_image.dart';
import '../entities/place_image_parameters.dart';

abstract class PlaceImageRepository {
  Future<Either<Failure, PlaceImage>> call(PlaceImageParameters parameters);
}
