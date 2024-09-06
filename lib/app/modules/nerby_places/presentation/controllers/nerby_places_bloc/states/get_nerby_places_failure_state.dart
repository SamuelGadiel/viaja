import 'nerby_places_states.dart';

class GetNerbyPlacesFailureState implements NerbyPlacesStates {
  final String message;

  const GetNerbyPlacesFailureState(this.message);
}
