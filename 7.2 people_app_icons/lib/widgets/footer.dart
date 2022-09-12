import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        shape: const Border(),
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: Column(
              children: [
                const Text('Copyright 2022'),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Link(
                    uri: Uri.parse('https://edu.fudeo.it'),
                    target: LinkTarget.blank,
                    builder: (context, callback) => InkWell(
                      onTap: callback,
                      child: const Text(
                        'Fudeo',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
