import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pexels_app/misc/no_transitions_builder.dart';
import 'package:pexels_app/pages/detail_page.dart';
import 'package:pexels_app/pages/photos_page.dart';
import 'package:pexels_app/repositories/pexels_repository.dart';
import 'package:pexels_app/routing/app_route_observer.dart';
import 'package:pexels_app/routing/routes.dart';
import 'package:pexels_app/services/pexels_service.dart';
import 'package:provider/provider.dart';
import 'package:seo_renderer/seo_renderer.dart';

class App extends StatelessWidget {
  final _routeObserver = AppRouteObserver();

  App({Key? key}) : super(key: key);

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
          Provider.value(value: _routeObserver),
        ],
        child: RobotDetector(
          child: MaterialApp(
            title: 'Pexels App',
            initialRoute: RouteNames.cars,
            navigatorObservers: [
              seoRouteObserver,
              _routeObserver,
            ],
            routes: {
              RouteNames.cars: (_) => const PhotosPage(title: 'Cars'),
              RouteNames.animals: (_) => const PhotosPage(title: 'Animals'),
              RouteNames.cities: (_) => const PhotosPage(title: 'Cities'),
              RouteNames.sport: (_) => const PhotosPage(title: 'Sport'),
              RouteNames.fun: (_) => const PhotosPage(title: 'Fun'),
            },
            onGenerateRoute: (settings) {
              if (settings.name?.contains(RouteNames.details) ?? false) {
                final id = settings.arguments as int?;
                final queryId =
                    int.parse(Uri.base.queryParameters['id'] ?? '1');

                return MaterialPageRoute(
                  builder: (context) => DetailPage(id ?? queryId),
                );
              }

              return null;
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
        ),
      );
}
