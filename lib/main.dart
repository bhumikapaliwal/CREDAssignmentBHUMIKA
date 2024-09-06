import 'package:credassignment/Services/service_provider.dart';
import 'package:credassignment/screens/homepage.dart';
import 'package:credassignment/screens/secondpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => CategoryProvider(),
      child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo.shade900),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/':(context)=>HomePage(),
        '/categories':(context)=>CategoriesPage(),
      },
    ),
    );
  }
}


