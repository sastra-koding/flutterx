import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'main_cubit.g.dart';

// Buat sebuah state untuk menyimpan informasi autentikasi
@JsonSerializable()
class MainState extends Equatable {
  final String? locale;

  const MainState({
    this.locale,
  });

  MainState copyWith({
    String? locale,
  }) =>
      MainState(
        locale: locale ?? this.locale,
      );

  @override
  List<Object?> get props => [locale];
}

// Buat sebuah cubit yang akan menangani state management untuk MainState
class MainCubit extends HydratedCubit<MainState> {
  MainCubit()
      : super(const MainState(
          locale: 'en',
        ));

  @override
  MainState fromJson(Map<String, dynamic> json) => _$MainStateFromJson(json);

  @override
  Map<String, dynamic> toJson(MainState state) => _$MainStateToJson(state);

  // Metode untuk melakukan logout
  void setLocale(String locale) {
    emit(state.copyWith(
      locale: locale,
    ));
  }
}
