import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/secrets/google_secrets.dart';
import '../../../core/shared/failures/failure.dart';
import '../../../core/shared/settings/request_settings.dart';
import '../entities/prediction_details.dart';
import '../errors/prediction_details_erorrs.dart';
import '../failures/prediction_details_failures.dart';
import '../mappers/prediction_details_mapper.dart';

class PredictionDetailsDatasource {
  final Dio dio;

  PredictionDetailsDatasource(this.dio);

  Future<Either<Failure, PredictionDetails>> call(String placeId) async {
    try {
      final response = await dio.get(
        '${RequestSettings.placesBaseAPI}/details/json',
        queryParameters: {
          'placeid': placeId,
          'key': GoogleSecrets.key,
          'components': 'country:br',
          'language': 'pt-BR',
        },
      );

      switch (response.statusCode) {
        case 200:
          return Right(PredictionDetailsMapper.fromJson(response.data));
        default:
          throw PredictionDetailsError('Não foi possivel obter os detalhes do local');
      }
    } on PredictionDetailsError catch (e) {
      return Left(PredictionDetailsFailure(e.message));
    } on Exception catch (e) {
      return Left(PredictionDetailsFailure(e.toString()));
    }
  }
}
