import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:testproject/core/error/failures.dart';
import 'package:testproject/core/network/di/di.dart';
import 'package:testproject/core/network/safe_api_call.dart';
import 'package:testproject/core/network/service/api_client.dart';
import 'package:testproject/features/register/domain/ripository/register_repository.dart';
import 'package:testproject/features/register/domain/usecase/register_usecase.dart';

@LazySingleton(as: RegisterRepository, env: [Env.dev, Env.prod])
class RegisterRepositoryImpl extends SafeApiCall implements RegisterRepository {
  RegisterRepositoryImpl(super.networkInfo, this.apiClient);
  final ApiClient apiClient;
  @override
  Future<Either<Failure, bool>> register(RegisterParams params) async {
    // TODO: implement register
    throw UnimplementedError();
  }
}
