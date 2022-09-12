import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/blocs/consent/consent_bloc.dart';
import 'package:social_network/cubits/auth/auth_cubit.dart';
import 'package:social_network/pages/home_page.dart';
import 'package:social_network/pages/welcome_page.dart';
import 'package:social_network/widgets/cookie_policy.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          _mainContent,
          _cookiePolicy,
        ],
      );

  Widget get _mainContent => BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) => state is CheckAuthenticationState
            ? const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : state is AuthenticatedState
                ? HomePage(user: state.user)
                : const WelcomePage(),
      );

  Widget get _cookiePolicy => BlocBuilder<ConsentBloc, ConsentState>(
        builder: (context, state) => state is UndefinedConsent
            ? Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: CookiePolicy(
                  onTapAccepted: () =>
                      context.read<ConsentBloc>().allowConsent(),
                  onTapDenied: () => context.read<ConsentBloc>().denyConsent(),
                ),
              )
            : const SizedBox(),
      );
}
