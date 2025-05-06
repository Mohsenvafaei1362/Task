import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:testproject/core/local_storage/save_todo.dart';
import 'package:testproject/core/utils/strings.dart';
import 'package:testproject/features/register/domain/usecase/register_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

@injectable
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUsecase registerUsecase;
  final ToDoPreferences toDoPreferences;
  String? username;
  String? password;

  RegisterBloc(this.registerUsecase, this.toDoPreferences)
    : super(RegisterInitial()) {
    on<Registeration>(_registeration);
  }

  FutureOr<void> _registeration(
    Registeration event,
    Emitter<RegisterState> emit,
  ) async {
    try {
      emit(RegisterLoading());
      final either = await registerUsecase(event.params);
      either.fold((l) => left(emit(ErrorData(l.message))), (r) {
        return right(emit(RegisterSuccess()));
      });
    } catch (e) {
      emit(ErrorData(GENERAL_ERROR));
    }
  }
}
