//main

import 'dart:io';

import 'package:fittrack/utils/routes/routes.dart';
import 'package:fittrack/utils/routes/routes_name.dart';
import 'package:fittrack/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthViewModel())],
      child: const MyApp(),
    ),
  );
}
/*
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtén una referencia al AuthViewModel
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    // Llama a checkAndRedirect en el momento adecuado
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      authViewModel.checkAndRedirect(context);
    });

    return MaterialApp(
      title: "FitTrack",
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: RoutesName.login,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
*/

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => AuthViewModel())],
        child: MaterialApp(
          title: "FitTrack",
          theme: ThemeData(primarySwatch: Colors.blue),
          initialRoute: RoutesName.login,
          onGenerateRoute: Routes.generateRoute,
        ));
  }
}
