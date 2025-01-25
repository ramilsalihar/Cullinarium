import 'package:cullinarium/core/di/injections.dart';
import 'package:cullinarium/core/navigation/app_router.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final _appRouter = sl<AppRouter>();

    return MaterialApp.router(
      title: 'Culinarium',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
