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
  Widget build(BuildContext context) =>
      LayoutBuilder(builder: (context, constraints) {
        final width = constraints.maxWidth;
        final showDrawer = width <= 700;
        final showEmail = width > 1400;

        return Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          drawer: showDrawer ? const AppDrawer() : null,
          body: Row(
            children: [
              if (!showDrawer) const AppDrawer(),
              _emails(showEmail: showEmail),
            ],
          ),
        );
      });

  Widget _emails({bool showEmail = false}) => Expanded(
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
            if (showEmail) const VerticalDivider(width: 0),
            if (showEmail)
              const Expanded(
                child: SizedBox(),
              ),
          ],
        ),
      );
}
