import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_cubit.g.dart';

// Buat sebuah state untuk menyimpan informasi autentikasi
@JsonSerializable()
class AppState extends Equatable {
  final bool isAuthenticated;
  final String email;
  final String name;
  final int counter;

  const AppState({
    required this.isAuthenticated,
    required this.email,
    required this.name,
    required this.counter,
  });

  AppState copyWith({
    bool? isAuthenticated,
    String? email,
    String? name,
    int? counter,
  }) {
    return AppState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      email: email ?? this.email,
      name: name ?? this.name,
      counter: counter ?? this.counter,
    );
  }

  @override
  List<Object?> get props => [isAuthenticated, email, name, counter];
}

// Buat sebuah event untuk mengubah status autentikasi
abstract class AppEvent {}

class LoginEvent extends AppEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class LogoutEvent extends AppEvent {}

// Buat sebuah cubit yang akan menangani state management untuk AppState
class AppCubit extends HydratedCubit<AppState> {
  AppCubit()
      : super(const AppState(
          isAuthenticated: false,
          email: '',
          name: '',
          counter: 0,
        ));

  @override
  AppState fromJson(Map<String, dynamic> json) => _$AppStateFromJson(json);

  @override
  Map<String, dynamic> toJson(AppState state) => _$AppStateToJson(state);

  void login(String email, String name) {
    bool isAuthenticated = true;

    if (isAuthenticated) {
      emit(state.copyWith(
        isAuthenticated: true,
        email: email,
        name: name,
      ));
    }
  }

  // Metode untuk melakukan logout
  void logout() {
    emit(state.copyWith(
      isAuthenticated: false,
      email: '',
      name: '',
      counter: 0,
    ));
  }

  void incrementCounter() {
    emit(state.copyWith(
      counter: state.counter + 1,
    ));
  }

  void decrementCounter() {
    emit(state.copyWith(
      counter: state.counter - 1,
    ));
  }
}
