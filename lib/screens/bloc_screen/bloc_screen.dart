import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterx/store/blocs/app/app_bloc.dart';

class BlocScreen extends StatelessWidget {
  const BlocScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);

    void authenticateUser() {
      if (appBloc.state.isAuthenticated) {
        appBloc.add(LogoutEvent());
      } else {
        appBloc.add(
          const LoginEvent(email: 'example@example.com', name: 'John Doe'),
        );
      }
    }

    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Bloc Screen')),
          floatingActionButton: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              if (state.isAuthenticated) ...[
                FloatingActionButton(
                  heroTag: 'increment',
                  child: const Icon(Icons.add),
                  onPressed: () => appBloc.add(IncrementCounterEvent()),
                ),
                const SizedBox(height: 4),
                FloatingActionButton(
                  heroTag: 'decrement',
                  child: const Icon(Icons.remove),
                  onPressed: () => appBloc.add(DecrementCounterEvent()),
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
                  const Text(
                    'All state on this screen is managed and persisted by the bloc',
                    textAlign: TextAlign.center,
                  ),
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
