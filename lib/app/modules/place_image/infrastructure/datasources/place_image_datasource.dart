import '../../domain/entities/place_image.dart';
import '../../domain/entities/place_image_parameters.dart';

abstract class PlaceImageDatasource {
  Future<PlaceImage> call(PlaceImageParameters parameters);
}
