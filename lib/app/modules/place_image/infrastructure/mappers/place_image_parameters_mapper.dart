import '../../../../core/secrets/google_secrets.dart';
import '../../domain/entities/place_image_parameters.dart';

class PlaceImageParametersMapper {
  static Map<String, dynamic> toJson(PlaceImageParameters parameters) {
    return {
      'photo_reference': parameters.photoReference,
      'maxwidth' : 1600,
      'key': GoogleSecrets.key,
    };
  }
}
