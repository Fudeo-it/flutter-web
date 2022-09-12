import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Semantics(
        label: 'Loading',
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
}
