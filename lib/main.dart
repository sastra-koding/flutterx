import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterx/screens/bloc_screen/bloc_screen.dart';
import 'package:flutterx/screens/cubit_screen/cubit_screen.dart';
import 'package:flutterx/store/cubits/main/main_cubit.dart';
import 'package:flutterx/store/providers.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi HydratedStorage
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        routes: {
          '/cubit': (context) => const CubitScreen(),
          '/bloc': (context) => const BlocScreen(),
        },
        home: const MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainCubit = BlocProvider.of<MainCubit>(context);

    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Main Screen')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/cubit'),
                  child: const Text('Go to Cubit Screen'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/bloc'),
                  child: const Text('Go to BLoC Screen'),
                ),
                RadioListTile(
                  title: const Text('Indonesian'),
                  value: 'id',
                  groupValue: state.locale,
                  selected: state.locale == 'id',
                  onChanged: (value) => mainCubit.setLocale(value!),
              ),

              RadioListTile(
                  title: const Text('English'),
                  value: 'en', 
                  selected: state.locale == 'en',
                  groupValue: state.locale, 
                  onChanged: (value) => mainCubit.setLocale(value!),
              ),
              ],
            ),
          ),
        );
      },
    );
  }
}
