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
        create: (context) => AppCubit(),
        child: const AuthScreen(),
      ),
    );
  }
}

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appCubit = BlocProvider.of<AppCubit>(context);

    void authenticateUser() {
      if (appCubit.state.isAuthenticated) {
        appCubit.logout();
      } else {
        appCubit.login('example@example.com', 'John Doe');
      }
    }

    return BlocBuilder<AppCubit, AppState>(
      builder: (_, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Main Screen'),
          ),
          floatingActionButton: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              if (state.isAuthenticated) ...[
                FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () => appCubit.incrementCounter(),
                ),
                const SizedBox(height: 4),
                FloatingActionButton(
                  child: const Icon(Icons.remove),
                  onPressed: () => appCubit.decrementCounter(),
                ),
                const SizedBox(height: 4),
              ],
              FloatingActionButton(
                onPressed: authenticateUser,
                child: state.isAuthenticated
                    ? const Icon(Icons.logout)
                    : const Icon(Icons.login),
              ),
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state.isAuthenticated) ...[
                  Text(
                    '${state.counter}',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Text('Email: ${state.email}'),
                  Text('Name: ${state.name}'),
                ] else ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'You are not authenticated, please\nclick login button below',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ]
              ],
            ),
          ),
        );
      },
    );
  }
}
