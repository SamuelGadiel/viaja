import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../place_image/presentation/controllers/place_image_bloc/place_image_bloc.dart';
import '../../../place_image/presentation/controllers/stores/place_image_store.dart';
import 'place_image_carousel.dart';

class PlaceInformationBar extends StatefulWidget {
  const PlaceInformationBar({super.key});

  @override
  State<PlaceInformationBar> createState() => _PlaceInformationBarState();
}

class _PlaceInformationBarState extends State<PlaceInformationBar> {
  final placeImageBloc = Modular.get<PlaceImageBloc>();
  final placeImageStore = Modular.get<PlaceImageStore>();

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
      child: const Column(
        children: [
          SizedBox(
            height: 250,
            child: PlaceImageCarousel(),
          ),
        ],
      ),
    );
  }
}
