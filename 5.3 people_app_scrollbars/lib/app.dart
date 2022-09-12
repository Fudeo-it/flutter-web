import 'package:flutter/material.dart';
import 'package:people_app/pages/people_page.dart';
import 'package:people_app/routing/routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'People App',
        initialRoute: RouteNames.people,
        routes: {
          RouteNames.people: (_) => const PeoplePage(),
        },
        theme: ThemeData(primarySwatch: Colors.green),
      );
}
