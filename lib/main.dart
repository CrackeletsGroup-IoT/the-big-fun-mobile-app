import 'package:big_fun_app/config/router/app_router.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(
     const MainApp()
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'The Big Fun App',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
