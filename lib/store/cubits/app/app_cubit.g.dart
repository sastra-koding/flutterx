// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) => AppState(
      isAuthenticated: json['isAuthenticated'] as bool,
      email: json['email'] as String,
      name: json['name'] as String,
      counter: json['counter'] as int,
    );

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'isAuthenticated': instance.isAuthenticated,
      'email': instance.email,
      'name': instance.name,
      'counter': instance.counter,
    };
