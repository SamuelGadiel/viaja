import '../../../../core/shared/failures/failure.dart';

abstract class PlaceImageFailures implements Failure {
  final String message;

  const PlaceImageFailures({required this.message});
}
