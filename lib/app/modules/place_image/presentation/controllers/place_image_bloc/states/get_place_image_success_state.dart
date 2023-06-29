import '../../../../domain/entities/place_image.dart';
import 'place_image_states.dart';

class GetPlaceImageSuccessState implements PlaceImageStates {
  final PlaceImage placeImage;

  const GetPlaceImageSuccessState(this.placeImage);
}
