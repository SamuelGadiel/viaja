import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../../../core/shared/settings/request_settings.dart';
import '../../domain/entities/place_image.dart';
import '../../domain/entities/place_image_parameters.dart';
import '../../infrastructure/datasources/place_image_datasource.dart';
import '../../infrastructure/errors/place_image_error.dart';
import '../../infrastructure/mappers/place_image_parameters_mapper.dart';

class PlaceImageDatasourceImplementation implements PlaceImageDatasource {
  final Dio dio;

  PlaceImageDatasourceImplementation(this.dio);

  @override
  Future<PlaceImage> call(PlaceImageParameters parameters) async {
    final response = await dio.get(
      '${RequestSettings.placesBaseAPI}/photo',
      queryParameters: PlaceImageParametersMapper.toJson(parameters),
      options: Options(responseType: ResponseType.bytes)
    );

    if (response.statusCode != 200) {
      throw const PlaceImageError('Não foi possivel obter a imagem');
    }

    return PlaceImage(Uint8List.fromList(response.data));
  }
}
