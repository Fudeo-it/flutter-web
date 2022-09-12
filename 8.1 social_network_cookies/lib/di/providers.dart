part of 'dependency_injector.dart';

class _Providers extends StatelessWidget {
  final Widget child;

  const _Providers({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<Logger>(
            create: (_) => Logger(),
          ),
          Provider<AuthService>(
            create: (_) => AuthService(
                'https://servatedb.vercel.app/api/fudeo-flutter-2-focus'),
          ),
          Provider<ImagePickerService>(
            create: (_) => ImagePickerServiceImpl(),
          ),
          Provider<CookieService>(
            create: (_) => CookieService(),
          ),
          Provider<ConsentService>(
            create: (context) => CookieConsentService(
              cookieService: context.read(),
            ),
          ),
        ],
        child: child,
      );
}
