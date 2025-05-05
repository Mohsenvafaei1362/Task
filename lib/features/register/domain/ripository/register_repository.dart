import 'package:dartz/dartz.dart';
import 'package:testproject/core/error/failures.dart';
import 'package:testproject/features/register/domain/usecase/register_usecase.dart';

abstract class RegisterRepository {
  Future<Either<Failure, bool>> register(RegisterParams params);
}
