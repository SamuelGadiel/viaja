import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../place_image/presentation/controllers/place_image_bloc/place_image_bloc.dart';
import '../../../place_image/presentation/controllers/place_image_bloc/states/place_image_states.dart';
import '../../../place_image/presentation/controllers/stores/place_image_store.dart';

class PlaceImageCarousel extends StatefulWidget {
  const PlaceImageCarousel({super.key});

  @override
  State<PlaceImageCarousel> createState() => _PlaceImageCarouselState();
}

class _PlaceImageCarouselState extends State<PlaceImageCarousel> {
  final placeImageBloc = Modular.get<PlaceImageBloc>();
  final placeImageStore = Modular.get<PlaceImageStore>();

  int currentPage = 0;
  late Timer bannerTimer;
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();

    bannerTimer = Timer.periodic(
      const Duration(seconds: 6),
      (timer) {
        if (pageController.page! == placeImageStore.images.length - 1) {
          pageController.animateToPage(0, duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
        } else {
          pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
        }
      },
    );

    pageController.addListener(() {
      final int next = pageController.page!.round();

      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
  }

  @override
  void dispose() {
    bannerTimer.cancel();
    pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceImageBloc, PlaceImageStates>(
      bloc: placeImageBloc,
      builder: (context, state) {
        return PageView.builder(
          controller: pageController,
          itemCount: placeImageStore.images.length,
          itemBuilder: (context, currentIndex) {
            final Uint8List? image = placeImageStore.images.entries.elementAtOrNull(currentIndex)?.value;

            if (image == null) {
              return const SizedBox();
            }

            return Image.memory(
              image,
              fit: BoxFit.cover,
              height: 300,
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox();
              },
            );
          },
        );
      },
    );
  }
}
