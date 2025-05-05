import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:testproject/core/network/di/di.dart';

abstract class DioLoggerInterceptor {
  Interceptor provideLogger();

  Interceptor provideCurlLogger();
}

@LazySingleton(as: DioLoggerInterceptor, env: [Env.mock, Env.dev])
class DioLoggerInterceptorMockImpl implements DioLoggerInterceptor {
  @override
  Interceptor provideLogger() => PrettyDioLogger(
    requestBody: true,
    requestHeader: true,
    responseHeader: true,
  );

  @override
  Interceptor provideCurlLogger() => CurlLoggerDioInterceptor();
}

@LazySingleton(as: DioLoggerInterceptor, env: [Env.prod])
class DioLoggerInterceptorImpl implements DioLoggerInterceptor {
  @override
  Interceptor provideLogger() => const Interceptor();

  @override
  Interceptor provideCurlLogger() => const Interceptor();
}
