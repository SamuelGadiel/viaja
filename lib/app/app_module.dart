import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/routes/routes.dart';
import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => Dio()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Routes.home, module: HomeModule()),
  ];
}
