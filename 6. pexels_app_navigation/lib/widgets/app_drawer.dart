import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pexels_app/routing/routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

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
                    onTap: () async {
                      await Navigator.pushNamed(context, RouteNames.cars);
                    },
                  ),
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.dog),
                    title: const Text('Animals'),
                    onTap: () async {
                      await Navigator.pushNamed(context, RouteNames.animals);
                    },
                  ),
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.city),
                    title: const Text('Cities'),
                    onTap: () async {
                      await Navigator.pushNamed(context, RouteNames.cities);
                    },
                  ),
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.basketball),
                    title: const Text('Sport'),
                    onTap: () async {
                      await Navigator.pushNamed(context, RouteNames.sport);
                    },
                  ),
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.faceSmile),
                    title: const Text('Fun'),
                    onTap: () async {
                      await Navigator.pushNamed(context, RouteNames.fun);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
