import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppCubitState> {
  AppCubit() : super(AppCubitState.light());

  void toggleTheme() {
    emit(state.brightness == Brightness.dark ? AppCubitState.light() : AppCubitState.dark());
  }

  void incrementCounter() {
    emit(state.copyWith(counter: state.counter + 1));
  }

  void decrementCounter() {
    emit(state.copyWith(counter: state.counter - 1));
  }
}

class AppCubitState {
  final ThemeData themeData;
  final Brightness brightness;
  final int counter;

  AppCubitState._({required this.themeData, required this.brightness, required this.counter});

  factory AppCubitState.light() {
    return AppCubitState._(
      themeData: ThemeData(
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
        ),
        brightness: Brightness.light,
      ),
      brightness: Brightness.light,
      counter: 0,
    );
  }

  factory AppCubitState.dark() {
    return AppCubitState._(
      themeData: ThemeData(
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.black,
        ),
        brightness: Brightness.dark,
      ),
      brightness: Brightness.dark,
      counter: 0,
    );
  }

  AppCubitState copyWith({ThemeData? themeData, Brightness? brightness, int? counter}) {
    return AppCubitState._(
      themeData: themeData ?? this.themeData,
      brightness: brightness ?? this.brightness,
      counter: counter ?? this.counter,
    );
  }
}