import '../../../../domain/entities/nerby_places_parameters.dart';
import 'nerby_places_events.dart';

class GetNerbyPlacesEvent implements NerbyPlacesEvents {
  final NerbyPlacesParameters parameters;

  const GetNerbyPlacesEvent(this.parameters);
}
