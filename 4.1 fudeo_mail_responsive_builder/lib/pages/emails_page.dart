import 'package:flutter/material.dart';
import 'package:fudeo_mail_reusable/models/email.dart';
import 'package:fudeo_mail_reusable/widgets/app_drawer.dart';
import 'package:fudeo_mail_reusable/widgets/email_tile.dart';
import 'package:fudeo_mail_reusable/widgets/responsive_builder.dart';

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
      ResponsiveBuilder(builder: (context, deviceType) {
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          drawer: deviceType == DeviceType.phone ? const AppDrawer() : null,
          body: Row(
            children: [
              if (deviceType > DeviceType.phone) const AppDrawer(),
              _emails(showEmail: deviceType == DeviceType.desktop),
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
