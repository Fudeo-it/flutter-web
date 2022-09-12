import 'package:flutter/material.dart';
import 'package:fudeo_mail_reusable/pages/emails_page.dart';
import 'package:fudeo_mail_reusable/routing/routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fudeo Mail',
      initialRoute: RouteNames.inbox,
      routes: {
        RouteNames.inbox: (_) => const EmailsPage(title: 'Inbox', emails: 30),
        RouteNames.drafts: (_) => const EmailsPage(title: 'Drafts', emails: 5),
        RouteNames.sent: (_) => const EmailsPage(title: 'Sent', emails: 30),
        RouteNames.spam: (_) => const EmailsPage(title: 'Spam', emails: 10),
        RouteNames.trash: (_) => const EmailsPage(title: 'Trash', emails: 20),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
