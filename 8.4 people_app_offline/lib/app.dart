import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people_app/pages/add_person_page.dart';
import 'package:people_app/pages/people_page.dart';
import 'package:people_app/repositories/people_repository.dart';
import 'package:people_app/routing/routes.dart';
import 'package:people_app/services/people_service.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider(create: (_) => PeopleService()),
          RepositoryProvider(
            create: (context) => PeopleRepository(
              peopleService: context.read(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'People App',
          initialRoute: RouteNames.people,
          routes: {
            RouteNames.people: (_) => PeoplePage(),
            RouteNames.add: (_) => const AddPersonPage(),
          },
          theme: ThemeData(
            primarySwatch: Colors.green,
            inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.zero),
              ),
            ),
          ),
        ),
      );
}
