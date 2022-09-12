import 'package:flutter/material.dart';

typedef LayoutWidgetBuilder = Widget Function(BuildContext context);

class GridBuilder extends StatelessWidget {
  final LayoutWidgetBuilder extraSmall;
  final LayoutWidgetBuilder small;
  final LayoutWidgetBuilder medium;
  final LayoutWidgetBuilder large;
  final LayoutWidgetBuilder extraLarge;

  const GridBuilder({
    required this.extraSmall,
    required this.small,
    required this.medium,
    required this.large,
    required this.extraLarge,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      if (constraints.maxWidth >= 2000) {
        return extraLarge(context);
      } else if (constraints.maxWidth >= 1600) {
        return large(context);
      } else if (constraints.maxWidth >= 1200) {
        return medium(context);
      } else if (constraints.maxWidth >= 800) {
        return small(context);
      } else {
        return extraSmall(context);
      }
    }
  );
}
