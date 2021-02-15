import 'package:get_it/get_it.dart';
import 'package:sported_app/services/auth.dart';
import 'package:sported_app/services/storage_repo.dart';
import 'package:sported_app/view_controller/user_controller.dart';

final locator = GetIt.instance;

void setupServices() {
  locator.registerSingleton<AuthMethods>(AuthMethods());
  locator.registerSingleton<StorageRepo>(StorageRepo());
  locator.registerSingleton<UserController>(UserController());
}