abstract class PredictionDetailsErrors implements Exception {}

class PredictionDetailsError implements PredictionDetailsErrors {
  final String message;

  PredictionDetailsError(this.message);
}
