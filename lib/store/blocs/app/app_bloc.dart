import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_event.dart';
part 'app_state.dart';
part 'app_bloc.g.dart';

class AppBloc extends HydratedBloc<AppEvent, AppState> {
  AppBloc()
      : super(const AppState(
          isAuthenticated: false,
          email: '',
          name: '',
          counter: 0,
        )) {
    on<LoginEvent>((event, emit) {
      bool isAuthenticated = true;

      if (isAuthenticated) {
        emit(state.copyWith(
          isAuthenticated: true,
          email: event.email,
          name: event.name,
        ));
      }
    });

    on<LogoutEvent>((event, emit) {
      emit(state.copyWith(
        isAuthenticated: false,
        email: '',
        name: '',
        counter: 0,
      ));
    });

    on<IncrementCounterEvent>((event, emit) {
      emit(state.copyWith(
        counter: state.counter + 1,
      ));
    });

    on<DecrementCounterEvent>((event, emit) {
      emit(state.copyWith(
        counter: state.counter - 1,
      ));
    });
  }

  @override
  AppState? fromJson(Map<String, dynamic> json) => AppState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(AppState state) => state.toJson();
}
