import 'package:hydrated_bloc/hydrated_bloc.dart';

// Buat sebuah state untuk menyimpan informasi autentikasi
class AuthState {
  final bool isAuthenticated;
  final String email;
  final String name;
  final int age;

  AuthState({
    required this.isAuthenticated,
    required this.email,
    required this.name,
    required this.age,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    String? email,
    String? name,
    int? age,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      email: email ?? this.email,
      name: name ?? this.name,
      age: age ?? this.age,
    );
  }
}

// Buat sebuah event untuk mengubah status autentikasi
abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class LogoutEvent extends AuthEvent {}

// Buat sebuah cubit yang akan menangani state management untuk AuthState
class AuthCubit extends HydratedCubit<AuthState> {
  AuthCubit()
      : super(AuthState(
          isAuthenticated: false,
          email: '',
          name: '',
          age: 0,
        ));

  @override
  AuthState fromJson(Map<String, dynamic> json) {
    return AuthState(
      isAuthenticated: json['isAuthenticated'] as bool,
      email: json['email'] as String,
      name: json['name'] as String,
      age: json['age'] as int,
    );
  }

  @override
  Map<String, dynamic> toJson(AuthState state) {
    return {
      'isAuthenticated': state.isAuthenticated,
      'email': state.email,
      'name': state.name,
      'age': state.age,
    };
  }

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