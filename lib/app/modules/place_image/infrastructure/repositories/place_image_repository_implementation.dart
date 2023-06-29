import 'package:dartz/dartz.dart';

import '../../../../core/shared/failures/failure.dart';
import '../../domain/entities/place_image.dart';
import '../../domain/entities/place_image_parameters.dart';
import '../../domain/failures/place_image_failure.dart';
import '../../domain/repositories/place_image_repository.dart';
import '../datasources/place_image_datasource.dart';
import '../errors/place_image_error.dart';

class PlaceImageRepositoryImplementation implements PlaceImageRepository {
  final PlaceImageDatasource datasource;

  PlaceImageRepositoryImplementation(this.datasource);

  @override
  Future<Either<Failure, PlaceImage>> call(PlaceImageParameters parameters) async {
    try {
      return Right(await datasource(parameters));
    } on PlaceImageError catch (e) {
      return Left(PlaceImageFailure(message: e.message));
    } on Exception catch (e) {
      return Left(PlaceImageFailure(message: e.toString()));
    }
  }
}
