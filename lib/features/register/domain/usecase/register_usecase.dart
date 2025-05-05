import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:testproject/core/error/failures.dart';
import 'package:testproject/core/network/usecase/usecase.dart';
import 'package:testproject/features/register/domain/ripository/register_repository.dart';

@singleton
class RegisterUsecase extends UseCase<bool, RegisterParams> {
  final RegisterRepository registerRepository;

  RegisterUsecase(this.registerRepository);

  @override
  Future<Either<Failure, bool>> call(RegisterParams params) async {
    return await registerRepository.register(params);
  }
}

class RegisterParams {
  final String firstName;
  final String lastName;
  final int? age;

  RegisterParams({required this.firstName, required this.lastName, this.age});
}
