import 'package:flutter/material.dart';
import 'package:social_network/pages/login_page.dart';
import 'package:social_network/theme.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(64),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: <Color>[
                  CustomTheme.loginGradientStart,
                  CustomTheme.loginGradientEnd
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 1.0),
                stops: <double>[0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Column(
            children: [
              _welcomeWidget(context),
              _signInButton(context),
            ],
          ),
        ),
      );

  Widget _welcomeWidget(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            height: MediaQuery.of(context).size.height / 3,
            fit: BoxFit.fitWidth,
            image: const AssetImage('assets/img/login_logo.png'),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 48.0),
            child: Text(
              'SocialBook',
              style: TextStyle(
                color: Colors.white,
                fontSize: 48.0,
                fontFamily: 'WorkSansBold',
              ),
            ),
          ),
        ],
      );

  Widget _signInButton(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: ElevatedButton(
          child: const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 48.0,
            ),
            child: Text(
              'INIZIA',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontFamily: 'WorkSansBold',
              ),
            ),
          ),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          ),
        ),
      );
}
