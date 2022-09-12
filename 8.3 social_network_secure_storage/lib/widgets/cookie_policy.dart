import 'package:flutter/material.dart';

class CookiePolicy extends StatelessWidget {
  final VoidCallback? onTapAccepted;
  final VoidCallback? onTapDenied;

  const CookiePolicy({
    Key? key,
    this.onTapAccepted,
    this.onTapDenied,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.black,
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(
          horizontal: 128.0,
          vertical: 64.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informativa',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Text(
                'Noi e terze parti selezionate utilizziamo cookie o tecnologie simili per finalità tecniche e, con il tuo consenso, anche per “misurazione” come specificato nella cookie policy. Il rifiuto del consenso può rendere non disponibili le relative funzioni. Puoi liberamente prestare, rifiutare o revocare il tuo consenso, in qualsiasi momento.',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 36.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        onPressed: onTapDenied,
                        child: const Text('Rifiuta'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        onPressed: onTapAccepted,
                        child: const Text('Accetta'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
