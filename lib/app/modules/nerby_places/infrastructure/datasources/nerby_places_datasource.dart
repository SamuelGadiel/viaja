import '../../domain/entities/nerby_places.dart';
import '../../domain/entities/nerby_places_parameters.dart';

abstract class NerbyPlacesDatasource {
  Future<NerbyPlaces> call(NerbyPlacesParameters parameters);
}
