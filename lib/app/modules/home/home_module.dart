import 'package:flutter_modular/flutter_modular.dart';

import '../nerby_places/domain/usecases/get_nerby_places.dart';
import '../nerby_places/external/datasources/nerby_places_datasource_implementation.dart';
import '../nerby_places/infrastructure/repositories/nerby_places_repository_implementation.dart';
import '../nerby_places/presentation/controllers/nerby_places_bloc/nerby_places_bloc.dart';
import '../nerby_places/presentation/controllers/stores/nerby_places_store.dart';
import '../place_image/domain/usecases/get_place_image.dart';
import '../place_image/external/datasources/place_image_datasource_implementation.dart';
import '../place_image/infrastructure/repositories/place_image_repository_implementation.dart';
import '../place_image/presentation/controllers/place_image_bloc/place_image_bloc.dart';
import '../place_image/presentation/controllers/stores/place_image_store.dart';
import '../prediction/datasource/predictions_datasource.dart';
import '../prediction/notifiers/prediction_notifier/prediction_notifier.dart';
import '../prediction_details/datasource/prediction_details_datasource.dart';
import '../prediction_details/notifier/prediction_details_notifier.dart';
import 'presentation/home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => PredictionsDatasource(i())),
    Bind((i) => PredictionNotifier(i())),
    Bind((i) => PredictionDetailsDatasource(i())),
    Bind((i) => PredictionDetailsNotifier(i())),
    //
    Bind((i) => GetPlaceImageImplementation(i())),
    Bind((i) => PlaceImageRepositoryImplementation(i())),
    Bind((i) => PlaceImageDatasourceImplementation(i())),
    Bind((i) => PlaceImageStore()),
    Bind((i) => PlaceImageBloc(i(), i())),

    //
    Bind((i) => GetNerbyPlacesImplementation(i())),
    Bind((i) => NerbyPlacesRepositoryImplementation(i())),
    Bind((i) => NerbyPlacesDatasourceImplementation(i())),
    Bind((i) => NerbyPlacesStore()),
    Bind((i) => NerbyPlacesBloc(i(), i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (context, args) => const HomePage()),
  ];
}
