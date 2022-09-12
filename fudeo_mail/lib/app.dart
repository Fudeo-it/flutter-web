import 'package:flutter/material.dart';
import 'package:fudeo_mail_reusable/pages/drafts_page.dart';
import 'package:fudeo_mail_reusable/pages/inbox_page.dart';
import 'package:fudeo_mail_reusable/pages/sent_page.dart';
import 'package:fudeo_mail_reusable/pages/spam_page.dart';
import 'package:fudeo_mail_reusable/pages/trash_page.dart';
import 'package:fudeo_mail_reusable/routing/routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fudeo Mail',
      initialRoute: RouteNames.inbox,
      routes: {
        RouteNames.inbox: (_) => const InboxPage(),
        RouteNames.drafts: (_) => const DraftsPage(),
        RouteNames.sent: (_) => const SentPage(),
        RouteNames.spam: (_) => const SpamPage(),
        RouteNames.trash: (_) => const TrashPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
