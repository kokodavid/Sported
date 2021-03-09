import 'package:get_it/get_it.dart';
import 'package:sported_app/services/authentication_service.dart';
import 'package:sported_app/view_controller/user_controller.dart';

import 'data/services/auth.dart';
import 'data/services/storage_repo.dart';

final locator = GetIt.instance;

void setupServices() {
  locator.registerSingleton<AuthMethods>(AuthMethods());
  locator.registerSingleton<StorageRepo>(StorageRepo());
  locator.registerSingleton<AuthenticationService>(AuthenticationService());
  locator.registerSingleton<UserController>(UserController());
}
