part of 'app_bloc.dart';

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

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);

  Map<String, dynamic> toJson() => _$AppStateToJson(this);

  @override
  List<Object?> get props => [isAuthenticated, email, name, counter];
}
