import '../entities/prediction_details.dart';
import '../failures/prediction_details_failures.dart';

abstract class PredictionDetailsStates {}

class PredictionDetailsInitialState implements PredictionDetailsStates {}

class GetPredictionDetailsSuccessState implements PredictionDetailsStates {
  final PredictionDetails predictionDetails;

  GetPredictionDetailsSuccessState(this.predictionDetails);
}

class GetPredictionDetailsLoadingState implements PredictionDetailsStates {}

class GetPredictionDetailsFailureState implements PredictionDetailsStates {
  final PredictionDetailsFailure failure;

  GetPredictionDetailsFailureState(this.failure);
}
