part of 'dependency_injector.dart';

class _Blocs extends StatelessWidget {
  final Widget child;

  const _Blocs({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(
              userRepository: context.read(),
            )..checkAuthenticationState(),
          ),
          BlocProvider<ConsentBloc>(
            create: (context) => ConsentBloc(
              consentRepository: context.read(),
            )..getConsent(),
          ),
        ],
        child: child,
      );
}
