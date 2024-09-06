import '../../../../core/shared/failures/failure.dart';

abstract class NerbyPlacesFailures implements Failure {
  final String message;

  const NerbyPlacesFailures({required this.message});
}
