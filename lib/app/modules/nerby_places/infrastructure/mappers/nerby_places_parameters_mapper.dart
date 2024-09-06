import '../../../../core/secrets/google_secrets.dart';
import '../../domain/entities/nerby_places_parameters.dart';

class NerbyPlacesParametersMapper {
  static Map<String, dynamic> toJson(NerbyPlacesParameters parameters) {
    return {
      'location': '${parameters.lat},${parameters.long}',
      'radius': 5000,
      'type': 'restaurant',
      'language': 'pt-BR',
      'key': GoogleSecrets.key,
    };
  }
}
