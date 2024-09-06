import '../../../../domain/entities/nerby_places.dart';
import 'nerby_places_states.dart';

class GetNerbyPlacesSuccessState implements NerbyPlacesStates {
  final NerbyPlaces nerbyPlaces;

  const GetNerbyPlacesSuccessState(this.nerbyPlaces);
}
