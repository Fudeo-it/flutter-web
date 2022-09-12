import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pexels_app/routing/app_route_observer.dart';
import 'package:pexels_app/routing/routes.dart';

class AppDrawer extends StatefulWidget {
  final AppRouteObserver routeObserver;

  const AppDrawer({required this.routeObserver, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> with RouteAware {

  String? _selectedRoute;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    widget.routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    widget.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    _updateSelectedRoute();
  }

  @override
  void didPop() {
    _updateSelectedRoute();
  }

  @override
  Widget build(BuildContext context) => Drawer(
        child: Row(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const UserAccountsDrawerHeader(
                    decoration: BoxDecoration(),
                    accountName: Text(
                      'Angelo Cassano',
                      style: TextStyle(color: Colors.black87),
                    ),
                    accountEmail: Text(
                      'angelo@fudeo.it',
                      style: TextStyle(color: Colors.black87),
                    ),
                    currentAccountPicture: CircleAvatar(
                      child: Icon(Icons.android),
                    ),
                  ),
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.car),
                    title: const Text('Cars'),
                    selected: _selectedRoute == RouteNames.cars,
                    onTap: () async {
                      await Navigator.pushReplacementNamed(
                          context, RouteNames.cars);
                    },
                  ),
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.dog),
                    title: const Text('Animals'),
                    selected: _selectedRoute == RouteNames.animals,
                    onTap: () async {
                      await Navigator.pushReplacementNamed(
                          context, RouteNames.animals);
                    },
                  ),
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.city),
                    title: const Text('Cities'),
                    selected: _selectedRoute == RouteNames.cities,
                    onTap: () async {
                      await Navigator.pushReplacementNamed(
                          context, RouteNames.cities);
                    },
                  ),
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.basketball),
                    title: const Text('Sport'),
                    selected: _selectedRoute == RouteNames.sport,
                    onTap: () async {
                      await Navigator.pushReplacementNamed(
                          context, RouteNames.sport);
                    },
                  ),
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.faceSmile),
                    title: const Text('Fun'),
                    selected: _selectedRoute == RouteNames.fun,
                    onTap: () async {
                      await Navigator.pushReplacementNamed(
                          context, RouteNames.fun);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  void _updateSelectedRoute() {
    setState(() {
      _selectedRoute = ModalRoute.of(context)?.settings.name;
    });
  }
}
