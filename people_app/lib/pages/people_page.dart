import 'package:flutter/material.dart';
import 'package:people_app/widgets/app_drawer.dart';

class PeoplePage extends StatelessWidget {
  const PeoplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('People'),
        ),
        body: _body,
      );

  Widget get _body => Row(
        children: const [
          AppDrawer(),
          SizedBox(),
        ],
      );
}
