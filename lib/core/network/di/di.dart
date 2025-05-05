import 'package:testproject/core/network/di/di.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies({required String environment}) async {
  // Remove the init method call
  getIt.init(environment: environment);
}

abstract class Env {
  static const mock = 'mock';
  static const dev = 'dev';
  static const prod = 'prod';
}
