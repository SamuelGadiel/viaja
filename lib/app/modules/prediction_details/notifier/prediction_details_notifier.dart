import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../datasource/prediction_details_datasource.dart';
import '../entities/place_type.dart';
import '../entities/prediction_details.dart';
import '../failures/prediction_details_failures.dart';
import 'prediction_details_states.dart';

class PredictionDetailsNotifier extends ValueNotifier<PredictionDetailsStates> implements Disposable {
  final PredictionDetailsDatasource datasource;

  PredictionDetailsNotifier(this.datasource) : super(PredictionDetailsInitialState());

  PredictionDetails predictionDetails = PredictionDetails(
    numberOfRatings: -1,
    placeCity: '',
    rating: -1,
    placeCompleteName: '',
    placeName: '',
    placeState: '',
    lat: -18.9433022,
    long: -48.2924558,
    photosReference: [],
    type: PlaceType.location
  );

  Future<void> getPredictionDetails(String placeId) async {
    value = GetPredictionDetailsLoadingState();

    final result = await datasource(placeId);

    result.fold(
      (l) => value = GetPredictionDetailsFailureState(l as PredictionDetailsFailure),
      (r) {
        predictionDetails = r;
        return value = GetPredictionDetailsSuccessState(r);
      },
    );
  }
}
