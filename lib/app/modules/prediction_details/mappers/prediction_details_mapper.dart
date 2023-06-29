import '../entities/prediction_details.dart';

class PredictionDetailsMapper {
  static PredictionDetails fromJson(Map<String, dynamic> json) {
    final coordinates = json['result']?['geometry']?['location'] ?? {};

    return PredictionDetails(
      photosReference: ((json['result']?['photos'] ?? []) as List).map((e) => (e['photo_reference'] ?? '').toString()).toList(),
      lat: coordinates['lat'] ?? -18.9433022,
      long: coordinates['lng'] ?? -48.2924558,
    );
  }
}
