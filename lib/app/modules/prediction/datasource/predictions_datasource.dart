import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/secrets/google_secrets.dart';
import '../../../core/shared/failures/failure.dart';
import '../../../core/shared/settings/request_settings.dart';
import '../entities/prediction.dart';
import '../errors/get_predction_error.dart';
import '../failures/get_prediction_failure.dart';
import '../mappers/prediction_mapper.dart';

class PredictionsDatasource {
  final Dio dio;

  PredictionsDatasource(this.dio);

  Future<Either<Failure, List<Prediction>>> call(String query) async {
    try {
      final response = await dio.get(
        '${RequestSettings.placesBaseAPI}/autocomplete/json',
        queryParameters: {
          'input': query,
          'key': GoogleSecrets.key,
          'components': 'country:br',
          'language': 'pt-BR',
        },
      );

      switch (response.statusCode) {
        case 200:
          final rawPredictions = (response.data['predictions'] ?? []) as List;
          final List<Prediction> parsedPredictions = rawPredictions.map((e) => PredictionMapper.fromJson(e)).toList();

          return Right(parsedPredictions);
        default:
          throw GetPredictionError('Não foi possivel obter a lista de dados');
      }
    } on GetPredictionError catch (e) {
      return Left(GetPredictionFailure(e.message));
    } on Exception catch (e) {
      return Left(GetPredictionFailure(e.toString()));
    }
  }
}
