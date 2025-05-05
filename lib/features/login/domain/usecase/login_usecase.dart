import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:testproject/core/error/failures.dart';
import 'package:testproject/core/network/usecase/usecase.dart';
import 'package:testproject/features/login/domain/entities/response_entities.dart';
import 'package:testproject/features/login/domain/ripository/login_repository.dart';

@singleton
class LoginUsecase extends UseCase<ResponseEntities, LoginParams> {
  final LoginRepository loginRepository;

  LoginUsecase(this.loginRepository);

  @override
  Future<Either<Failure, ResponseEntities>> call(LoginParams params) async {
    return await loginRepository.login(params);
  }
}

class LoginParams {
  final String username;
  final String password;

  LoginParams({required this.username, required this.password});
}
