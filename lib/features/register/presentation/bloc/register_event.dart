part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class Registeration extends RegisterEvent {
  final RegisterParams params;

  const Registeration(this.params);

  @override
  List<Object> get props => [params];
}
