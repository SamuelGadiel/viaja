import '../../../core/shared/failures/failure.dart';

abstract class PredictionDetailsFailures implements Failure{}

class PredictionDetailsFailure implements PredictionDetailsFailures {
  final String message;

  PredictionDetailsFailure(this.message);
}
