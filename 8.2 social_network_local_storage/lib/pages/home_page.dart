import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/cubits/auth/auth_cubit.dart';
import 'package:social_network/models/user.dart';
import 'package:social_network/theme.dart';

class HomePage extends StatelessWidget {
  final User user;

  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        drawer: _drawer(
          context,
        ),
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
          child: _welcomeWidget(context),
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
          Padding(
            padding: const EdgeInsets.only(top: 48.0),
            child: RichText(
              text: TextSpan(
                text: 'Benvenuto, ',
                style: const TextStyle(
                  fontSize: 36.0,
                  fontFamily: 'WorkSansBold',
                ),
                children: [
                  TextSpan(
                    text: user.name,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  Widget _drawer(BuildContext context) => Drawer(
        child: Column(children: [
          Expanded(
            child: ListView(
              children: [
                _accountHeader(context),
              ],
            ),
          ),
          const Divider(height: 0),
          _logoutButton(context),
        ]),
      );

  Widget _accountHeader(BuildContext context) => UserAccountsDrawerHeader(
        decoration: const BoxDecoration(color: Colors.transparent),
        accountName: Text(
          user.name,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        accountEmail: Text(
          user.email,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        currentAccountPicture: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child:
              Text(user.initials, style: Theme.of(context).textTheme.headline6),
        ),
      );

  Widget _logoutButton(BuildContext context) => ListTile(
        leading: const Icon(Icons.logout),
        title: const Text('Esci'),
        onTap: () => _showLogoutDialog(context),
      );

  void _showLogoutDialog(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Logout'),
            content: const Text('Sei sicuro di voler uscire dal tuo account?'),
            actions: <Widget>[
              TextButton(
                child: const Text('Si'),
                onPressed: () {
                  context.read<AuthCubit>().logout();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: const Text('No'),
                  onPressed: () => Navigator.of(context).pop()),
            ],
          ),
        );
      },
    );
  }
}
