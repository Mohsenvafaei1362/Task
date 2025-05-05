import 'package:dartz/dartz.dart';
import 'package:testproject/core/error/failures.dart';
import 'package:testproject/features/login/domain/entities/response_entities.dart';
import 'package:testproject/features/login/domain/usecase/login_usecase.dart';

abstract class LoginRepository {
  Future<Either<Failure, ResponseEntities>> login(LoginParams params);
}
