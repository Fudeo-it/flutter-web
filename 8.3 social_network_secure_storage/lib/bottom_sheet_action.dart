import 'package:flutter/material.dart';

class BottomSheetAction extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final String text;
  final VoidCallback? onTap;

  const BottomSheetAction(
    this.text, {
    Key? key,
    required this.icon,
    required this.backgroundColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: backgroundColor,
              ),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'WorkSansMedium',
                ),
              ),
            ),
          ],
        ),
      );
}
