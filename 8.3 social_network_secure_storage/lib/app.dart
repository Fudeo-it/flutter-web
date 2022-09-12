import 'package:flutter/material.dart';
import 'package:social_network/di/dependency_injector.dart';
import 'package:social_network/pages/main_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const DependencyInjector(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SocialLogin',
          home: MainPage(),
        ),
      );
}
