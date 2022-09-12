import 'package:flutter/material.dart';
import 'package:fudeo_mail_reusable/models/email.dart';
import 'package:fudeo_mail_reusable/widgets/app_drawer.dart';
import 'package:fudeo_mail_reusable/widgets/email_tile.dart';

class EmailsPage extends StatelessWidget {
  final String title;
  final int emails;

  const EmailsPage({
    required this.title,
    required this.emails,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Row(
          children: [
            const AppDrawer(),
            _emails(),
          ],
        ),
      );

  Widget _emails() => Expanded(
        child: Row(
          children: [
            Expanded(
              child: () {
                final emails = Email.emails(this.emails);

                return ListView.separated(
                  itemBuilder: (context, index) {
                    final email = emails[index];

                    return EmailTile(email);
                  },
                  separatorBuilder: (_, __) => const Divider(height: 0),
                  itemCount: emails.length,
                );
              }(),
            ),
            const VerticalDivider(width: 0),
            const Expanded(
              child: SizedBox(),
            ),
          ],
        ),
      );
}
