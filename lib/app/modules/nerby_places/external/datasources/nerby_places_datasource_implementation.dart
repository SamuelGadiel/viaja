import 'package:dio/dio.dart';

import '../../../../core/shared/settings/request_settings.dart';
import '../../domain/entities/nerby_places.dart';
import '../../domain/entities/nerby_places_parameters.dart';
import '../../infrastructure/datasources/nerby_places_datasource.dart';
import '../../infrastructure/errors/nerby_places_error.dart';
import '../../infrastructure/mappers/nerby_places_mapper.dart';
import '../../infrastructure/mappers/nerby_places_parameters_mapper.dart';

class NerbyPlacesDatasourceImplementation implements NerbyPlacesDatasource {
  final Dio dio;

  NerbyPlacesDatasourceImplementation(this.dio);

  @override
  Future<NerbyPlaces> call(NerbyPlacesParameters parameters) async {
    final response = await dio.get(
      '${RequestSettings.placesBaseAPI}/nearbysearch/json',
      queryParameters: NerbyPlacesParametersMapper.toJson(parameters),
    );

    if (response.statusCode != 200) {
      throw const NerbyPlacesError('Não foi possivel obter as recomendações');
    }

    return NerbyPlacesMapper.fromJson(response.data);
  }
}
