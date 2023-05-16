import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterx/blocs/app/app_cubit.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getTemporaryDirectory(),
    );
  } catch (e) {
    // Jika gagal membuat storage, aplikasi akan tetap berjalan
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => AuthCubit(),
        child: const AuthScreen(),
      ),
    );
  }
}

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state.isAuthenticated) {
          // Jika sudah terautentikasi, tampilkan informasi pengguna
          return Scaffold(
            appBar: AppBar(
              title: const Text('Auth Screen'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Email: ${state.email}'),
                  Text('Name: ${state.name}'),
                  Text('Age: ${state.age}'),
                  ElevatedButton(
                    onPressed: () {
                      // Lakukan logout
                      authCubit.logout();
                    },
                    child: const Text('Logout'),
                  ),
                ],
              ),
            ),
          );
        } else {
          // Jika belum terautentikasi, tampilkan form login
          return Scaffold(
            appBar: AppBar(
              title: const Text('Auth Screen'),
            ),
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  // Lakukan login dengan email dan password
                  authCubit.login('example@example.com', 'password');
                },
                child: const Text('Login'),
              ),
            ),
          );
        }
      },
    );
  }
}
