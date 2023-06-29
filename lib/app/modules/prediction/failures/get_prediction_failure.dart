import '../../../core/shared/failures/failure.dart';

class GetPredictionFailure implements Failure {
  final String failure;

  GetPredictionFailure(this.failure);
}
