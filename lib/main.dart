import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_1/bloc/products_bloc.dart';
import 'package:lab_1/bloc_observer.dart';
import 'package:lab_1/products/products_screen.dart';
import 'package:lab_1/services/products_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();

  runApp(
    RepositoryProvider(
      create: (context) => ProductsService(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ProductsBloc>(
            create: (BuildContext context) =>
                ProductsBloc(context.read<ProductsService>()),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ProductsScreen(),
    );
  }
}
