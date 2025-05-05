import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:testproject/core/network/dio_logger_interceptor.dart';
import 'package:testproject/core/network/service/api_client.dart';
import 'package:testproject/core/utils/constants.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio(DioLoggerInterceptor logger) {
    const duration = Duration(seconds: Constants.CONNECTION_TIMEOUT_SECONDS);
    final dio = Dio(
      BaseOptions(
        connectTimeout: duration,
        receiveTimeout: duration,
        sendTimeout: duration,
      ),
    );
    return dio
      ..interceptors.addAll([
        logger.provideLogger(),
        logger.provideCurlLogger(),
        QueuedInterceptorsWrapper(
          onRequest: (options, handler) async {
            // final authInfo = await AuthPreferencesImpl().getApiToken();
            // final authInfo = await AuthScureStorageImpl().getToken();
            // if (authInfo != null && authInfo.isNotEmpty) {
            //   options.headers['Authorization'] = 'Bearer $authInfo';
            // }

            handler.next(options);
          },
        ),
      ]);
  }

  @lazySingleton
  ApiClient apiClient(Dio dio) => ApiClient(dio, baseUrl: Constants.BASE_URL);
}
