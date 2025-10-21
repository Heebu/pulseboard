import 'package:stacked_services/stacked_services.dart';
import 'package:stacked/stacked.dart';
import '../core/services/data_service.dart';

final locator = StackedLocator.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DataService());
}
