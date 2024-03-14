import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:teste_mp/app/core/domain/entities/user_entity.dart';

import '../../core/infra/repositories/hive_user_repository.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final HiveUserRepository hiveRepository;
  CalendarBloc({ required this.hiveRepository}) : super(LoadingUsersState()) {
    on<GetUsersInHiveEvent>(_getUsersInHive);
  }

  Future<void> _getUsersInHive(GetUsersInHiveEvent event, emit) async {
      try{
        var users = await hiveRepository.getUsers();
        emit(UsersFetchedState(users));
      } catch(e){
        emit(CalendarExceptionState('error ao buscar do banco de dados'));
      }
  }
}

@immutable
abstract class CalendarEvent {}


class LoadingEvent extends CalendarEvent {
  LoadingEvent();
}

class GetUsersInHiveEvent extends CalendarEvent {
  GetUsersInHiveEvent();
}

@immutable
abstract class CalendarState {}

class LoadingUsersState extends CalendarState {
  LoadingUsersState();
}


class CalendarExceptionState extends CalendarState {
  final String message;

  CalendarExceptionState(this.message);
}

class UsersFetchedState extends CalendarState {
  final List<UserEntity> entities;

  UsersFetchedState(this.entities);
}
