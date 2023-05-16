import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterx/store/cubits/app/app_cubit.dart';

class CubitScreen extends StatelessWidget {
  const CubitScreen({super.key});

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
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Cubit Screen')),
          floatingActionButton: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              if (state.isAuthenticated) ...[
                FloatingActionButton(
                  heroTag: 'increment',
                  child: const Icon(Icons.add),
                  onPressed: () => appCubit.incrementCounter(),
                ),
                const SizedBox(height: 4),
                FloatingActionButton(
                  heroTag: 'decrement',
                  child: const Icon(Icons.remove),
                  onPressed: () => appCubit.decrementCounter(),
                ),
                const SizedBox(height: 4),
              ],
              FloatingActionButton(
                heroTag: 'auth',
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
