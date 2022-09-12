part of 'dependency_injector.dart';

class _Repositories extends StatelessWidget {
  final Widget child;

  const _Repositories({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(context) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider<UserRepository>(
            create: (context) => UserRepository(
              authService: context.read(),
              logger: context.read(),
            ),
          ),
          RepositoryProvider<ConsentRepository>(
            create: (context) => ConsentRepository(
              consentService: context.read(),
            ),
          ),
        ],
        child: child,
      );
}
