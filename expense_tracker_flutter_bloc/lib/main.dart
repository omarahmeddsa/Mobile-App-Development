import 'package:expense_tracker_flutter_bloc/pagecontroller/navigationcontroller_cubit.dart';
import 'package:expense_tracker_flutter_bloc/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'controller/expense_tracker_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getTemporaryDirectory()).path,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ExpenseTrackerBloc>(
          create: (context) => ExpenseTrackerBloc(),
        ),
        BlocProvider<NavigationcontrollerCubit>(
          create: (context) => NavigationcontrollerCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Expense Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromRGBO(75, 218, 249, 1),
          scaffoldBackgroundColor: const Color.fromRGBO(27, 35, 57, 1),
        ),
        home: const Expensehome(),
      ),
    );
  }
}
