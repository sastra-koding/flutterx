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
  final int age;

  const AppState({
    required this.isAuthenticated,
    required this.email,
    required this.name,
    required this.age,
  });

  AppState copyWith({
    bool? isAuthenticated,
    String? email,
    String? name,
    int? age,
  }) {
    return AppState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      email: email ?? this.email,
      name: name ?? this.name,
      age: age ?? this.age,
    );
  }

  @override
  List<Object?> get props => [isAuthenticated, email, name, age];
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
          age: 0,
        ));

  @override
  AppState fromJson(Map<String, dynamic> json) => _$AppStateFromJson(json);

  @override
  Map<String, dynamic> toJson(AppState state) => _$AppStateToJson(state);

  // Metode untuk melakukan login dengan email dan password
  void login(String email, String password) {
    // Lakukan proses autentikasi
    // Jika autentikasi berhasil, ubah state isAuthenticated menjadi true
    // Jika autentikasi gagal, biarkan state isAuthenticated menjadi false
    bool isAuthenticated = true; // contoh autentikasi berhasil
    if (isAuthenticated) {
      emit(state.copyWith(
        isAuthenticated: true,
        email: email,
      ));
    }
  }

  // Metode untuk melakukan logout
  void logout() {
    emit(state.copyWith(
      isAuthenticated: false,
      email: '',
      name: '',
      age: 0,
    ));
  }
}
