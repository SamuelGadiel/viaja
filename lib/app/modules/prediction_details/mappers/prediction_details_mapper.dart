import 'package:collection/collection.dart';

import '../entities/place_type.dart';
import '../entities/prediction_details.dart';

class PredictionDetailsMapper {
  static PredictionDetails fromJson(Map<String, dynamic>? json) {

    final coordinates = json?['geometry']?['location'] ?? {};

    final type = ((json?['types'] ?? []) as List).any((element) => element == 'establishment' || element == 'point_of_interest')
        ? PlaceType.establishment
        : PlaceType.location;

    return PredictionDetails(
      rating: json?['rating'] ?? -1,
      numberOfRatings: json?['user_ratings_total'] ?? -1,
      placeState: ((json?['address_components'] ?? []) as List).firstWhereOrNull(
            (addresses) => ((addresses['types'] ?? []) as List).any(
              (addressType) => addressType == 'administrative_area_level_1',
            ),
          )?['short_name'] ??
          '-',
      placeCity: ((json?['address_components'] ?? []) as List).firstWhereOrNull(
            (addresses) => ((addresses['types'] ?? []) as List).any(
              (addressType) => addressType == 'administrative_area_level_2',
            ),
          )?['short_name'] ??
          '-',
      type: type,
      placeName: json?['name'] ?? '-',
      placeCompleteName: json?['formatted_address'] ?? '-',
      photosReference: ((json?['photos'] ?? []) as List).map((e) => (e['photo_reference'] ?? '').toString()).toList(),
      lat: coordinates['lat'] ?? -18.9433022,
      long: coordinates['lng'] ?? -48.2924558,
    );
  }
}
