import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pexels_app/misc/no_transitions_builder.dart';
import 'package:pexels_app/pages/photos_page.dart';
import 'package:pexels_app/repositories/pexels_repository.dart';
import 'package:pexels_app/routing/routes.dart';
import 'package:pexels_app/services/pexels_service.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider(
            create: (_) => PexelsService(),
          ),
          Provider(
            create: (context) => PexelsRepository(
              pexelsService: context.read(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Pexels App',
          initialRoute: RouteNames.cars,
          routes: {
            RouteNames.cars: (_) => const PhotosPage(title: 'Cars'),
            RouteNames.animals: (_) => const PhotosPage(title: 'Animals'),
            RouteNames.cities: (_) => const PhotosPage(title: 'Cities'),
            RouteNames.sport: (_) => const PhotosPage(title: 'Sport'),
            RouteNames.fun: (_) => const PhotosPage(title: 'Fun'),
          },
          theme: ThemeData(
            primarySwatch: Colors.orange,
            cardTheme: CardTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            pageTransitionsTheme: PageTransitionsTheme(
                builders: kIsWeb
                    ? {
                        for (final platform in TargetPlatform.values)
                          platform: const NoTransitionsBuilder()
                      }
                    : const {}),
          ),
        ),
      );
}
