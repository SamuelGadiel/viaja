import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:google_places_flutter/google_places_flutter.dart';
// import 'package:google_places_flutter/model/prediction.dart';
import 'package:latlong2/latlong.dart' as lt;
import 'package:unicons/unicons.dart';

import '../../../core/shared/widgets/app_logo.dart';
import '../../place_image/domain/entities/place_image_parameters.dart';
import '../../place_image/presentation/controllers/place_image_bloc/events/get_place_image_event.dart';
import '../../place_image/presentation/controllers/place_image_bloc/place_image_bloc.dart';
import '../../place_image/presentation/controllers/stores/place_image_store.dart';
import '../../prediction/entities/prediction.dart';
import '../../prediction/notifiers/prediction_notifier/prediction_notifier.dart';
import '../../prediction/notifiers/prediction_notifier/predictions_state.dart';
import '../../prediction_details/notifier/prediction_details_notifier.dart';
import '../../prediction_details/notifier/prediction_details_states.dart';
import 'widgets/place_information_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = TextEditingController();
  final predictionNotifier = Modular.get<PredictionNotifier>();
  final predictionDetailsNotifier = Modular.get<PredictionDetailsNotifier>();

  final placeImageBloc = Modular.get<PlaceImageBloc>();
  final placeImageStore = Modular.get<PlaceImageStore>();

  final suggestionsBoxController = SuggestionsBoxController();

  final MapController mapController = MapController();

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      if (controller.text.isEmpty) {
        placeImageStore.images.clear();
        predictionNotifier.resetState();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: predictionDetailsNotifier,
        builder: (context, state, child) {
          if (state is GetPredictionDetailsSuccessState) {
            placeImageStore.images.clear();
            for (final photoReference in state.predictionDetails.photosReference) {
              placeImageBloc.add(GetPlaceImageEvent(PlaceImageParameters(photoReference)));
            }

            mapController.move(
              lt.LatLng(
                predictionDetailsNotifier.predictionDetails.lat,
                predictionDetailsNotifier.predictionDetails.long,
              ),
              14, // zoom
            );
          }

          return Stack(
            children: [
              FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  center: lt.LatLng(-18.9433022, -48.2924558),
                  zoom: 14,
                ),
                nonRotatedChildren: const [SimpleAttributionWidget(source: Text('Viajá'))],
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://www.google.com/maps/vt/pb=!1m4!1m3!1i{z}!2i{x}!3i{y}!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425',
                    userAgentPackageName: 'com.example.viaja',
                  ),
                ],
              ),
              Visibility(
                visible: state is PredictionDetailsInitialState,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: Container(
                      color: Colors.black.withOpacity(0.4),
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
              if (state is GetPredictionDetailsSuccessState) const PlaceInformationBar(),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: state is PredictionDetailsInitialState ? EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.25) : EdgeInsets.zero,
                width: MediaQuery.sizeOf(context).width,
                height: state is PredictionDetailsInitialState ? MediaQuery.sizeOf(context).height : 72,
                alignment: state is PredictionDetailsInitialState ? null : Alignment.center,
                decoration: BoxDecoration(
                  color: state is PredictionDetailsInitialState ? Colors.black54 : Colors.grey,
                  boxShadow: state is PredictionDetailsInitialState
                      ? []
                      : [
                          const BoxShadow(
                            offset: Offset(0, 3),
                            color: Colors.black26,
                            blurRadius: 16,
                          ),
                        ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Visibility(
                      visible: state is PredictionDetailsInitialState,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height * 0.08),
                        child: const AppLogo(showSubtitle: true),
                      ),
                    ),
                    ValueListenableBuilder<PredictionsStates>(
                      valueListenable: predictionNotifier,
                      builder: (context, state, child) {
                        BorderRadius border = BorderRadius.circular(32);
                        if (state is PredictionsLoadingState || state is PredictionsSuccessState) {
                          border = border - const BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32));
                        }

                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: border,
                            color: Colors.white,
                          ),
                          width: MediaQuery.sizeOf(context).width * 0.65,
                          height: 48,
                          child: Focus(
                            onFocusChange: (hasFocus) {
                              if (!hasFocus) {
                                predictionNotifier.resetState();
                              } else {
                                suggestionsBoxController.open();
                              }
                            },
                            child: TypeAheadField<Prediction>(
                              suggestionsBoxController: suggestionsBoxController,
                              minCharsForSuggestions: 1,
                              suggestionsBoxVerticalOffset: 1,
                              debounceDuration: const Duration(milliseconds: 500),
                              getImmediateSuggestions: true,
                              onSuggestionSelected: (prediction) {
                                controller.text = prediction.description;
                                predictionDetailsNotifier.getPredictionDetails(prediction.placeId);
                              },
                              loadingBuilder: (context) {
                                return const SizedBox(
                                  height: 200,
                                  child: Center(child: CircularProgressIndicator()),
                                );
                              },
                              noItemsFoundBuilder: (context) {
                                return const SizedBox(
                                  height: 200,
                                  child: Center(child: Text('Nenhum local encontrado')),
                                );
                              },
                              errorBuilder: (context, error) {
                                return const SizedBox(
                                  height: 200,
                                  child: Center(child: Text('Erro ao buscar locais')),
                                );
                              },
                              suggestionsCallback: (value) async {
                                List<Prediction> predictions = [];

                                await Future.wait([
                                  predictionNotifier.getPredictions(value),
                                ]).then((value) => predictions = predictionNotifier.predictions);

                                return predictions;
                              },
                              textFieldConfiguration: TextFieldConfiguration(
                                style: const TextStyle(fontSize: 22),
                                controller: controller,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                                  border: InputBorder.none,
                                  hintText: 'Busque uma cidade',
                                  hintStyle: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                              itemBuilder: (context, prediction) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                  child: Row(
                                    children: [
                                      Icon(UniconsLine.map_marker, color: Colors.grey.shade600),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 16),
                                          child: Text(
                                            prediction.description,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(fontSize: 22),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
