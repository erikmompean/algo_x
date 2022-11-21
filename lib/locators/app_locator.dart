import 'package:crypto_x/repositories/encrypted_prefernces_repository.dart';
import 'package:crypto_x/repositories/purestake_repository.dart';
import 'package:crypto_x/services/purestake_service.dart';
import 'package:get_it/get_it.dart';

class AppLocator {
  static void setup() {
    // _registerSingleton<AppNavigator>(AppNavigator());

    // Repositories
    _registerSingleton<EncryptedPreferencesRepository>(
        EncryptedPreferencesRepository());
    _registerSingleton<PureStakeRepository>(PureStakeRepository());

    // Services
    _registerSingleton<PureStakeService>(
        PureStakeService(locate<PureStakeRepository>()));
  }

  static void _registerSingleton<T extends Object>(T instance) {
    if (!GetIt.instance.isRegistered<T>()) {
      GetIt.instance.registerSingleton(instance);
    }
  }

  static void _registerLazySingleton<T extends Object>(
      T Function() factoryFunction) {
    if (!GetIt.instance.isRegistered<T>()) {
      GetIt.instance.registerLazySingleton(factoryFunction);
    }
  }

  static void _registerFactory<T extends Object>(T Function() factoryFunction) {
    if (!GetIt.instance.isRegistered<T>()) {
      GetIt.instance.registerFactory(factoryFunction);
    }
  }

  static T locate<T extends Object>() {
    var element = GetIt.instance.get<T>();

    return element;
  }
}
