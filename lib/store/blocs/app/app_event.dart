part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

class LoginEvent extends AppEvent {
  final String email;
  final String name;

  const LoginEvent({required this.email, required this.name});

  @override
  List<Object?> get props => [email, name];
}

class LogoutEvent extends AppEvent {}

class IncrementCounterEvent extends AppEvent {}

class DecrementCounterEvent extends AppEvent {}