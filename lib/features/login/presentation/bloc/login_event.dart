part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class Login extends LoginEvent {
  final LoginParams params;

  const Login({required this.params});

  @override
  List<Object> get props => [params];
}
