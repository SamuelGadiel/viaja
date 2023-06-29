import '../../../../core/shared/failures/failure.dart';
import '../../entities/prediction.dart';

abstract class PredictionsStates {}

class PredictionsInitialState implements PredictionsStates {}

class PredictionsSuccessState implements PredictionsStates {
  final List<Prediction> predictions;

  PredictionsSuccessState(this.predictions);
}

class PredictionsFailureState implements PredictionsStates {
  final Failure failure;

  PredictionsFailureState(this.failure);
}

class PredictionsLoadingState implements PredictionsStates {}
