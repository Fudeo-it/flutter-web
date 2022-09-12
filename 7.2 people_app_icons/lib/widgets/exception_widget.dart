import 'package:flutter/material.dart';

class ExceptionWidget extends StatelessWidget {
  const ExceptionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _title(context),
          _subtitle(context),
        ],
      );

  Widget _title(BuildContext context) => Text(
        'Uh oh!',
        style: Theme.of(context)
            .textTheme
            .headline4
            ?.copyWith(color: Colors.black),
      );

  Widget _subtitle(BuildContext context) => Text(
        'An error has occurred',
        style: Theme.of(context).textTheme.headline6,
      );
}
