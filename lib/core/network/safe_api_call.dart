// ignore_for_file: avoid_dynamic_calls

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:testproject/core/error/failures.dart';
import 'package:testproject/core/network/network_info.dart';

abstract class SafeApiCall {
  final NetworkInfo _networkInfo;

  SafeApiCall(this._networkInfo);

  Future<Either<Failure, T?>> call<T>(Future<HttpResponse<T>> apiCall) async {
    if (await _networkInfo.isConnected) {
      try {
        final httpResponse = await apiCall;
        if (httpResponse.response.statusCode == 200 ||
            httpResponse.response.statusCode == 201 ||
            httpResponse.response.statusCode == 204) {
          return right(httpResponse.data);
        } else {
          return left(const UnknownFailure());
        }
      } on DioException catch (error) {
        if (error.type == DioExceptionType.badResponse) {
          final response = error.response;
          // final json = response?.data;
          switch (response?.statusCode) {
            case 500:
              return left(ServerFailure());
            case 400:
              return left(ValidationFailure(message: 'Validation Error'));

            case 401:
              //! دریافت توکن جدید
              await _refreshToken();
              return left(const TimeOutFailure(message: '401'));
            /////////////////////////////////////////////////////////////////////////////
            // return left(
            //   const TimeOutFailure(message: '401'),
            // );
            default:
          }
        }
        return left(const UnknownFailure());
      }
    } else {
      return left(const InternetFailure());
      // final statusInternet = await AuthScureStorageImpl().getVpn();
      // if (statusInternet == 'vpn') {
      //   return left(const VpnFailure());
      // } else {
      //   return left(const InternetFailure());
      // }
    }
  }

  //! منطق برای دریافت توکن جدید
  Future<String?> _refreshToken() async {
    // final bloc = getIt<LoginBloc>();
    // final refreshToken = await bloc.authScureStorage.getrefreshToken();
    // // if (refreshToken != null) {
    // bloc.add(
    //   LoginStarted(
    //     loginParams: LoginParams(refreshToken: refreshToken),
    //   ),
    // );
    // }
    await Future.delayed(const Duration(milliseconds: 500));
    // final newToken = await bloc.authScureStorage.getToken();
    // return newToken;
    return null;
  }
}
