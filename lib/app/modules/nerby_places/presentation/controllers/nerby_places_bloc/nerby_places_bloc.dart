import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/failures/nerby_places_failure.dart';
import '../../../domain/usecases/get_nerby_places.dart';
import '../stores/nerby_places_store.dart';
import 'events/get_nerby_places_event.dart';
import 'events/nerby_places_events.dart';
import 'states/get_nerby_places_failure_state.dart';
import 'states/get_nerby_places_loading_state.dart';
import 'states/get_nerby_places_success_state.dart';
import 'states/nerby_places_initial_state.dart';
import 'states/nerby_places_states.dart';

class NerbyPlacesBloc extends Bloc<NerbyPlacesEvents, NerbyPlacesStates> implements Disposable {
  final GetNerbyPlaces usecase;
  final NerbyPlacesStore store;

  NerbyPlacesBloc(this.usecase, this.store) : super(const NerbyPlacesInitialState()) {
    on<GetNerbyPlacesEvent>(_mapGetNerbyPlacesEventToState);
  }

  @override
  Future<void> dispose() async => close();

  FutureOr<void> _mapGetNerbyPlacesEventToState(GetNerbyPlacesEvent event, Emitter<NerbyPlacesStates> emit) async {
    emit(const GetNerbyPlacesLoadingState());

    final result = await usecase(event.parameters);

    result.fold(
      (l) => emit(GetNerbyPlacesFailureState((l as NerbyPlacesFailure).message)),
      (r) {
        store.nerbyPlaces = r;
        emit(GetNerbyPlacesSuccessState(r));
      },
    );
  }
}
