import '../../../prediction_details/mappers/prediction_details_mapper.dart';
import '../../domain/entities/nerby_places.dart';

class NerbyPlacesMapper {
  static NerbyPlaces fromJson(Map<String, dynamic> json) {
    return NerbyPlaces(
      nearbyPlaces: ((json['results'] ?? []) as List).map((e) => PredictionDetailsMapper.fromJson(e)).toList(),
    );
  }
}
