import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterx/assets/helpers.dart';
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
          appBar: AppBar(title: Text(t(context, 'bloc_screen_title'))),
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
                  Text(
                    t(context, 'bloc_screen_alert'),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '${state.counter}',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Text('Email: ${state.email}'),
                  Text('${t(context, 'bloc_screen_name')}: ${state.name}'),
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      t(context, 'bloc_screen_login_alert'),
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
