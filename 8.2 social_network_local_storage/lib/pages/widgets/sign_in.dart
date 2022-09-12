import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_network/blocs/sign_in/sign_in_bloc.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController signInEmailController = TextEditingController();
  final TextEditingController signInPasswordController =
      TextEditingController();

  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodePassword = FocusNode();

  bool _obscureTextPassword = true;
  bool _formValid = false;

  @override
  void dispose() {
    focusNodeEmail.dispose();
    focusNodePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(_) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SignInBloc(
              userRepository: context.read(),
              authCubit: context.read(),
            ),
          ),
        ],
        child: BlocConsumer<SignInBloc, SignInState>(
          listener: (context, state) {
            _shouldNavigateToMainPage(context, state: state);
            _shouldShowErrorSignInDialog(context, state: state);
          },
          builder: (context, state) => Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Column(
              children: <Widget>[
                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: () {
                    final isValid = _formKey.currentState?.validate() ?? false;
                    setState(() {
                      _formValid = isValid;
                    });
                  },
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      _formWidget(context, enabled: state is! SigningInState),
                      _signInButton(context, loading: state is SigningInState),
                    ],
                  ),
                ),
                _forgotPasswordButton(
                  context,
                  enabled: state is! SigningInState,
                ),
              ],
            ),
          ),
        ),
      );

  Widget _formWidget(
    BuildContext context, {
    bool enabled = true,
  }) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Card(
          elevation: 2.0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Container(
            width: 300.0,
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 24.0,
            ),
            child: Column(
              children: <Widget>[
                _emailField(context, enabled: enabled),
                const Divider(height: 0),
                _passwordField(context, enabled: enabled),
              ],
            ),
          ),
        ),
      );

  Widget _emailField(
    BuildContext context, {
    bool enabled = true,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 24,
        ),
        child: TextFormField(
          enabled: enabled,
          focusNode: focusNodeEmail,
          controller: signInEmailController,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(
              fontFamily: 'WorkSansSemiBold',
              fontSize: 16.0,
              color: Colors.black),
          decoration: const InputDecoration(
            border: InputBorder.none,
            icon: Icon(
              FontAwesomeIcons.envelope,
              color: Colors.black,
              size: 22.0,
            ),
            hintText: 'Indirizzo Email',
            hintStyle:
                TextStyle(fontFamily: 'WorkSansSemiBold', fontSize: 17.0),
            errorStyle: TextStyle(fontSize: 10, height: 0.1),
          ),
          validator: (value) {
            if (!RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value ?? '')) {
              return 'Email non valida';
            }

            return null;
          },
          onFieldSubmitted: (_) {
            focusNodePassword.requestFocus();
          },
        ),
      );

  Widget _passwordField(
    BuildContext context, {
    bool enabled = true,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 24,
        ),
        child: TextFormField(
          enabled: enabled,
          focusNode: focusNodePassword,
          controller: signInPasswordController,
          obscureText: _obscureTextPassword,
          style: const TextStyle(
              fontFamily: 'WorkSansSemiBold',
              fontSize: 16.0,
              color: Colors.black),
          decoration: InputDecoration(
            border: InputBorder.none,
            icon: const Icon(
              FontAwesomeIcons.lock,
              size: 22.0,
              color: Colors.black,
            ),
            hintText: 'Password',
            hintStyle:
                const TextStyle(fontFamily: 'WorkSansSemiBold', fontSize: 17.0),
            errorStyle: const TextStyle(fontSize: 10, height: 0.1),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureTextPassword = !_obscureTextPassword;
                });
              },
              child: Icon(
                _obscureTextPassword
                    ? FontAwesomeIcons.eye
                    : FontAwesomeIcons.eyeSlash,
                size: 15.0,
                color: Colors.black,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.length < 8) {
              return 'Password troppo corta';
            }

            return null;
          },
          onFieldSubmitted: (_) {
            if (_formValid) {
              context.read<SignInBloc>().signIn(
                    email: signInEmailController.text,
                    password: signInPasswordController.text,
                  );
            }
          },
          textInputAction: TextInputAction.go,
        ),
      );

  Widget _signInButton(
    BuildContext context, {
    bool loading = false,
  }) =>
      Padding(
        padding: const EdgeInsets.only(top: 140.0),
        child: ElevatedButton(
          onPressed: !loading && _formValid
              ? () => context.read<SignInBloc>().signIn(
                    email: signInEmailController.text,
                    password: signInPasswordController.text,
                  )
              : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 48.0,
            ),
            child: !loading
                ? const Text(
                    'ACCEDI',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontFamily: 'WorkSansBold',
                    ),
                  )
                : const SizedBox(
                    height: 28,
                    width: 28,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      );

  Widget _forgotPasswordButton(
    BuildContext context, {
    bool enabled = true,
  }) =>
      Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: TextButton(
          onPressed: enabled ? () {} : null,
          child: const Text(
            'Password dimenticata?',
            style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: 'WorkSansMedium'),
          ),
        ),
      );

  void _shouldShowErrorSignInDialog(
    BuildContext context, {
    required SignInState state,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state is SignInErrorState) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Problemi durante il login'),
            content: const Text('Email o password errata.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      }
    });
  }

  void _shouldNavigateToMainPage(
    BuildContext context, {
    required SignInState state,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state is SignedInState) {
        Navigator.of(context).pop();
      }
    });
  }
}
