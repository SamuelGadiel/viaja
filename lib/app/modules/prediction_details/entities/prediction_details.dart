import 'place_type.dart';

class PredictionDetails {
  final double lat;
  final double long;
  final List<String> photosReference;

  final String placeCompleteName;
  final String placeCity;
  final String placeName;
  final String placeState;

  final double rating;
  final int numberOfRatings;

  final PlaceType type;

  PredictionDetails({
    required this.lat,
    required this.long,
    required this.photosReference,
    required this.placeCompleteName,
    required this.placeCity,
    required this.placeName,
    required this.placeState,
    required this.numberOfRatings,
    required this.rating,
    required this.type,
  });
}
