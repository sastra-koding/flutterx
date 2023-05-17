import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterx/store/cubits/app/app_cubit.dart';
import 'package:flutterx/store/blocs/app/app_bloc.dart';
import 'package:flutterx/store/cubits/main/main_cubit.dart';

List<BlocProvider> providers = [
  // Cubit
  BlocProvider<AppCubit>.value(value: AppCubit()),
  BlocProvider<MainCubit>.value(value: MainCubit()),
  // BLoC
  BlocProvider<AppBloc>.value(value: AppBloc()),
];
