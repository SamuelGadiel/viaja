import 'package:flutter_modular/flutter_modular.dart';

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
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (context, args) => const HomePage()),
  ];
}
