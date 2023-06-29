import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/failures/place_image_failure.dart';
import '../../../domain/usecases/get_place_image.dart';
import '../stores/place_image_store.dart';
import 'events/get_place_image_event.dart';
import 'events/place_image_events.dart';
import 'states/get_place_image_failure_state.dart';
import 'states/get_place_image_loading_state.dart';
import 'states/get_place_image_success_state.dart';
import 'states/place_image_initial_state.dart';
import 'states/place_image_states.dart';

class PlaceImageBloc extends Bloc<PlaceImageEvents, PlaceImageStates> implements Disposable {
  final GetPlaceImage usecase;
  final PlaceImageStore store;

  PlaceImageBloc(this.usecase, this.store) : super(const PlaceImageInitialState()) {
    on<GetPlaceImageEvent>(_mapGetPlaceImageEventToState);
  }

  @override
  Future<void> dispose() async => close();

  FutureOr<void> _mapGetPlaceImageEventToState(GetPlaceImageEvent event, Emitter<PlaceImageStates> emit) async {
    emit(const GetPlaceImageLoadingState());

    final result = await usecase(event.parameters);

    result.fold(
      (l) => emit(GetPlaceImageFailureState((l as PlaceImageFailure).message)),
      (r) {
        store.images[event.parameters.photoReference] = r.image;
        emit(GetPlaceImageSuccessState(r));
      },
    );
  }
}
