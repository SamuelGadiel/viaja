import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/helpers/debouncer.dart';
import '../../datasource/predictions_datasource.dart';
import '../../entities/prediction.dart';
import '../../failures/get_prediction_failure.dart';
import 'predictions_state.dart';

class PredictionNotifier extends ValueNotifier<PredictionsStates> implements Disposable {
  final PredictionsDatasource datasource;

  PredictionNotifier(this.datasource) : super(PredictionsInitialState());

  final Debouncer _debouncer = Debouncer(milliseconds: 500);
  List<Prediction> predictions = [];

  Future<void> getPredictions(String query) async {
    if (query.isEmpty) {
      value = PredictionsInitialState();
      return;
    }

    value = PredictionsLoadingState();

    // _debouncer.run(() async {
    final result = await datasource(query);

    result.fold(
      (l) => value = PredictionsFailureState(l as GetPredictionFailure),
      (r) {
        predictions = r;
        return value = PredictionsSuccessState(r);
      },
    );
    // });
  }

  Future<void> resetState() async {
    value = PredictionsInitialState();
  }

  @override
  void dispose() {
    _debouncer.dispose();

    super.dispose();
  }
}
