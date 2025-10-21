// import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../core/services/data_service.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator() async {
  // await StackedLocator.instance();
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DataService());
}
