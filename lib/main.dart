import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:product_api/feature/products/controller/bloc/product_bloc.dart';
import 'package:product_api/feature/products/controller/bloc/product_bloc_events.dart';
import 'package:product_api/feature/products/view/pages/product_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init('cart');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc()..add(FetchProductsEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Machine Test',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ProductListPage(),
      ),
    );
  }
}
