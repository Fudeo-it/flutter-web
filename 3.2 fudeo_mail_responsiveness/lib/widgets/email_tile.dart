import 'package:flutter/material.dart';
import 'package:fudeo_mail_reusable/models/email.dart';

class EmailTile extends StatelessWidget {
  final Email email;
  final VoidCallback? onTap;

  const EmailTile(
    this.email, {
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        onTap: onTap,
        isThreeLine: true,
        leading: _leading,
        title: _title,
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _subject,
            _body,
          ],
        ),
      );

  Widget get _leading => CircleAvatar(child: Text(email.initials));

  Widget get _title => Text(email.fullName);

  Widget get _subject => Text(email.subject);

  Widget get _body => Text(email.body, maxLines: 1);
}
