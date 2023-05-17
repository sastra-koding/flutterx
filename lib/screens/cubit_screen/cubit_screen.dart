import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterx/assets/helpers.dart';
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
          appBar: AppBar(title: Text(t(context, 'cubit_screen_title'))),
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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state.isAuthenticated) ...[
                  Text(
                    t(context, 'cubit_screen_alert'),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '${state.counter}',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Text('Email: ${state.email}'),
                  Text('${t(context, "cubit_screen_name")}: ${state.name}'),
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      t(context, 'cubit_screen_login_alert'),
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
