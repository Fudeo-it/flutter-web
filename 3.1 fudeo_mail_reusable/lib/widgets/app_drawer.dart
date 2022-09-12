import 'package:flutter/material.dart';
import 'package:fudeo_mail_reusable/routing/routes.dart';

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
                    leading: const Icon(Icons.mail),
                    title: const Text('Inbox'),
                    onTap: () async {
                      await Navigator.pushNamed(context, RouteNames.inbox);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.drafts),
                    title: const Text('Drafts'),
                    onTap: () async {
                      await Navigator.pushNamed(context, RouteNames.drafts);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.send),
                    title: const Text('Sent'),
                    onTap: () async {
                      await Navigator.pushNamed(context, RouteNames.sent);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.warning),
                    title: const Text('Spam'),
                    onTap: () async {
                      await Navigator.pushNamed(context, RouteNames.spam);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text('Trash'),
                    onTap: () async {
                      await Navigator.pushNamed(context, RouteNames.trash);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
