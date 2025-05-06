import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:testproject/core/local_storage/save_todo.dart';
import 'package:testproject/features/login/domain/entities/response_entities.dart';
import 'package:testproject/features/login/domain/usecase/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase loginUsecase;
  final ToDoPreferences toDoPreferences;

  ResponseEntities response = ResponseEntities();
  String? username;
  String? password;

  LoginBloc(this.loginUsecase, this.toDoPreferences) : super(LoginInitial()) {
    on<Login>(_login);
  }

  FutureOr<void> _login(Login event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    await Future.delayed(Duration(seconds: 2));
    emit(LoginSuccess());
  }
}
