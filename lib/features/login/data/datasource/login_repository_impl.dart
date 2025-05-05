import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:testproject/core/error/failures.dart';
import 'package:testproject/core/network/di/di.dart';
import 'package:testproject/core/network/safe_api_call.dart';
import 'package:testproject/core/network/service/api_client.dart';
import 'package:testproject/features/login/data/models/request/login_request.dart';
import 'package:testproject/features/login/domain/entities/response_entities.dart';
import 'package:testproject/features/login/domain/ripository/login_repository.dart';
import 'package:testproject/features/login/domain/usecase/login_usecase.dart';

@LazySingleton(as: LoginRepository, env: [Env.dev, Env.prod])
class LoginRepositoryImpl extends SafeApiCall implements LoginRepository {
  LoginRepositoryImpl(super.networkInfo, this.apiClient);
  final ApiClient apiClient;

  @override
  Future<Either<Failure, ResponseEntities>> login(LoginParams params) async {
    final request = LoginRequest(
      username: params.username,
      password: params.password,
    );
    final either = await call(apiClient.signIn(request));
    return either.fold((l) => left(l), (r) {
      final response = ResponseEntities(
        accessToken: r?.accessToken,
        email: r?.email,
        firstName: r?.firstName,
        lastName: r?.lastName,
        id: r?.id,
        image: r?.image,
        username: r?.username,
      );
      return right(response);
    });
  }
}
