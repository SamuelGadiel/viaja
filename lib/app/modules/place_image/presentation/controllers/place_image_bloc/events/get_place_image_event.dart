import '../../../../domain/entities/place_image_parameters.dart';
import 'place_image_events.dart';

class GetPlaceImageEvent implements PlaceImageEvents {
  final PlaceImageParameters parameters;

  const GetPlaceImageEvent(this.parameters);
}
