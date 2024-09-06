import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide WatchContext;
import 'package:flutter_modular/flutter_modular.dart';

import '../../../nerby_places/presentation/controllers/nerby_places_bloc/nerby_places_bloc.dart';
import '../../../nerby_places/presentation/controllers/nerby_places_bloc/states/get_nerby_places_failure_state.dart';
import '../../../nerby_places/presentation/controllers/nerby_places_bloc/states/get_nerby_places_loading_state.dart';
import '../../../nerby_places/presentation/controllers/nerby_places_bloc/states/get_nerby_places_success_state.dart';
import '../../../nerby_places/presentation/controllers/nerby_places_bloc/states/nerby_places_states.dart';
import '../../../place_image/presentation/controllers/place_image_bloc/place_image_bloc.dart';
import '../../../place_image/presentation/controllers/stores/place_image_store.dart';
import '../../../prediction_details/entities/place_type.dart';
import '../../../prediction_details/entities/prediction_details.dart';
import 'place_image_carousel.dart';

class PlaceInformationBar extends StatefulWidget {
  final PredictionDetails predictionDetails;

  const PlaceInformationBar(this.predictionDetails, {super.key});

  @override
  State<PlaceInformationBar> createState() => _PlaceInformationBarState();
}

class _PlaceInformationBarState extends State<PlaceInformationBar> {
  final placeImageBloc = Modular.get<PlaceImageBloc>();
  final placeImageStore = Modular.get<PlaceImageStore>();

  final nearbyPlacesBloc = Modular.get<NerbyPlacesBloc>();

  @override
  Widget build(BuildContext context) {
    context.watch<PlaceImageBloc>((bind) => bind.state);

    return Container(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width * 0.25,
      padding: const EdgeInsets.only(top: 72),
      constraints: const BoxConstraints(maxWidth: 400, minWidth: 250),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(3, 0),
            color: Colors.black26,
            blurRadius: 16,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 250,
            child: PlaceImageCarousel(),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Visibility(
                        visible: widget.predictionDetails.type == PlaceType.location,
                        replacement: Text(
                          widget.predictionDetails.placeName,
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.predictionDetails.placeCity,
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                            ),
                            Text(widget.predictionDetails.placeState),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: widget.predictionDetails.rating != -1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow.shade600,
                                size: 28,
                              ),
                              const SizedBox(width: 4),
                              Text(widget.predictionDetails.rating.toString(), style: const TextStyle(fontSize: 20)),
                            ],
                          ),
                          Text(
                            '(${widget.predictionDetails.numberOfRatings})',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(color: Colors.grey, height: 32),
                BlocBuilder<NerbyPlacesBloc, NerbyPlacesStates>(
                  bloc: nearbyPlacesBloc,
                  builder: (context, state) {
                    if (state is GetNerbyPlacesFailureState) {
                      return Text(state.message);
                    }

                    if (state is GetNerbyPlacesLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is GetNerbyPlacesSuccessState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text('Locais', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.48,
                            child: ListView.builder(
                              itemCount: state.nerbyPlaces.nearbyPlaces.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final place = state.nerbyPlaces.nearbyPlaces.elementAt(index);

                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Card(
                                    elevation: 0,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Visibility(
                                            visible: place.type == PlaceType.location,
                                            replacement: Text(
                                              place.placeName,
                                              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  place.placeCity,
                                                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                                                ),
                                                Text(place.placeState),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: place.rating != -1,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.yellow.shade600,
                                                    size: 28,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(place.rating.toString(), style: const TextStyle(fontSize: 20)),
                                                ],
                                              ),
                                              Text(
                                                '(${place.numberOfRatings})',
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 6),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }

                    return const SizedBox();
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
