import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_network/blocs/image_picker/image_picker_bloc.dart';
import 'package:social_network/blocs/sign_up/sign_up_bloc.dart';
import 'package:social_network/bottom_sheet_action.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode focusNodePassword = FocusNode();
  final FocusNode focusNodeConfirmPassword = FocusNode();
  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodeName = FocusNode();

  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;
  bool _formValid = false;

  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController signUpNameController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController signUpConfirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    focusNodePassword.dispose();
    focusNodeConfirmPassword.dispose();
    focusNodeEmail.dispose();
    focusNodeName.dispose();
    super.dispose();
  }

  @override
  Widget build(_) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ImagePickerBloc(
              imagePickerService: context.read(),
            ),
          ),
          BlocProvider(
            create: (context) => SignUpBloc(
              userRepository: context.read(),
            ),
          ),
        ],
        child: BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state) {
            _shouldShowSuccessSignUpDialog(context, state: state);
            _shouldShowErrorSignUpDialog(context, state: state);
          },
          builder: (context, state) => Padding(
            padding: const EdgeInsets.only(top: 16.0),
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
                    //alignment: Alignment.bottomCenter,
                    children: [
                      _formWidget(context, enabled: state is! SigningUpState),
                      _avatarWidget(context, enabled: state is! SigningUpState),
                      _signUpButton(context, loading: state is SigningUpState),
                    ],
                  ),
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
      Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 48.0,
            bottom: 20.0,
          ),
          child: Card(
            elevation: 2.0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Container(
              width: 300.0,
              padding: const EdgeInsets.only(
                top: 32.0,
                bottom: 24.0,
              ),
              child: Column(
                children: <Widget>[
                  _nameField(context, enabled: enabled),
                  const Divider(height: 0),
                  _emailField(context, enabled: enabled),
                  const Divider(height: 0),
                  _passwordField(context, enabled: enabled),
                  const Divider(height: 0),
                  _confirmPasswordField(context, enabled: enabled),
                ],
              ),
            ),
          ),
        ),
      );

  Widget _avatarWidget(
    BuildContext context, {
    bool enabled = true,
  }) =>
      Positioned.fill(
        child: Align(
          alignment: Alignment.topCenter,
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(48),
            ),
            child: BlocBuilder<ImagePickerBloc, ImagePickerState>(
              builder: (context, state) => InkWell(
                customBorder: const CircleBorder(),
                onTap: enabled
                    ? () {
                        final imagePickerBloc = context.read<ImagePickerBloc>();

                        showModalBottomSheet(
                          context: context,
                          builder: (context) => _bottomSheetPicker(
                            context,
                            imagePickerBloc: imagePickerBloc,
                            picked: state is PickedImageState,
                          ),
                        );
                      }
                    : null,
                child: CircleAvatar(
                  backgroundImage: state is PickedImageState
                      ? FileImage(state.imageFile)
                      : null,
                  radius: 48.0,
                  child: () {
                    if (state is NoImagePickedState) {
                      return const Icon(
                        FontAwesomeIcons.camera,
                        size: 24.0,
                      );
                    } else if (state is LoadingImageState) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return Container();
                  }(),
                ),
              ),
            ),
          ),
        ),
      );

  Widget _nameField(
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
          focusNode: focusNodeName,
          controller: signUpNameController,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          autocorrect: false,
          style: const TextStyle(
              fontFamily: 'WorkSansSemiBold',
              fontSize: 16.0,
              color: Colors.black),
          decoration: const InputDecoration(
            border: InputBorder.none,
            icon: Icon(
              FontAwesomeIcons.user,
              color: Colors.black,
            ),
            hintText: 'Nome',
            hintStyle:
                TextStyle(fontFamily: 'WorkSansSemiBold', fontSize: 16.0),
            errorStyle: TextStyle(fontSize: 10, height: 0.1),
          ),
          validator: (value) {
            if (value == null || value.length < 8) {
              return 'Nome troppo corto';
            }

            return null;
          },
          onFieldSubmitted: (_) {
            focusNodeEmail.requestFocus();
          },
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
          controller: signUpEmailController,
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          style: const TextStyle(
              fontFamily: 'WorkSansSemiBold',
              fontSize: 16.0,
              color: Colors.black),
          decoration: const InputDecoration(
            border: InputBorder.none,
            icon: Icon(
              FontAwesomeIcons.envelope,
              color: Colors.black,
            ),
            hintText: 'Indirizzo Email',
            hintStyle:
                TextStyle(fontFamily: 'WorkSansSemiBold', fontSize: 16.0),
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
          controller: signUpPasswordController,
          obscureText: _obscureTextPassword,
          autocorrect: false,
          style: const TextStyle(
              fontFamily: 'WorkSansSemiBold',
              fontSize: 16.0,
              color: Colors.black),
          decoration: InputDecoration(
            border: InputBorder.none,
            icon: const Icon(
              FontAwesomeIcons.lock,
              color: Colors.black,
            ),
            hintText: 'Password',
            hintStyle:
                const TextStyle(fontFamily: 'WorkSansSemiBold', fontSize: 16.0),
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
            focusNodeConfirmPassword.requestFocus();
          },
        ),
      );

  Widget _confirmPasswordField(
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
          focusNode: focusNodeConfirmPassword,
          controller: signUpConfirmPasswordController,
          obscureText: _obscureTextConfirmPassword,
          autocorrect: false,
          style: const TextStyle(
              fontFamily: 'WorkSansSemiBold',
              fontSize: 16.0,
              color: Colors.black),
          decoration: InputDecoration(
            border: InputBorder.none,
            icon: const Icon(
              FontAwesomeIcons.lock,
              color: Colors.black,
            ),
            hintText: 'Conferma Password',
            hintStyle:
                const TextStyle(fontFamily: 'WorkSansSemiBold', fontSize: 16.0),
            errorStyle: const TextStyle(fontSize: 10, height: 0.1),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
                });
              },
              child: Icon(
                _obscureTextConfirmPassword
                    ? FontAwesomeIcons.eye
                    : FontAwesomeIcons.eyeSlash,
                size: 15.0,
                color: Colors.black,
              ),
            ),
          ),
          validator: (value) {
            if (signUpPasswordController.text != value) {
              return 'Le password non corrispondono';
            }

            return null;
          },
          onFieldSubmitted: (_) {
            if (_formValid) {
              context.read<SignUpBloc>().signUp(
                    name: signUpNameController.text,
                    email: signUpEmailController.text,
                    password: signUpPasswordController.text,
                  );
            }
          },
          textInputAction: TextInputAction.go,
        ),
      );

  Widget _signUpButton(
    BuildContext context, {
    bool loading = true,
  }) =>
      Positioned.fill(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
            onPressed: !loading && _formValid
                ? () => context.read<SignUpBloc>().signUp(
                      name: signUpNameController.text,
                      email: signUpEmailController.text,
                      password: signUpPasswordController.text,
                    )
                : null,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
              child: !loading
                  ? const Text(
                      'INVIA',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontFamily: 'WorkSansBold'),
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
        ),
      );

  Widget _bottomSheetPicker(
    BuildContext context, {
    required ImagePickerBloc imagePickerBloc,
    bool picked = false,
  }) {
    final List<dynamic> actions = [
      if (picked)
        {
          "icon": FontAwesomeIcons.trash,
          "color": Colors.red,
          "text": "Rimuovi",
          "action": () => imagePickerBloc.reset(),
        },
      {
        "icon": FontAwesomeIcons.fileImage,
        "color": Colors.blue,
        "text": "Galleria",
        "action": () => imagePickerBloc.pickLibraryImage(),
      },
      {
        "icon": FontAwesomeIcons.camera,
        "color": Colors.orange,
        "text": "Fotocamera",
        "action": () => imagePickerBloc.pickCameraImage(),
      }
    ];

    return Card(
      margin: EdgeInsets.zero,
      child: Container(
        height: 160,
        width: double.maxFinite,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Immagine del profilo",
                style: TextStyle(
                  fontFamily: 'WorkSansSemiBold',
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 8),
                scrollDirection: Axis.horizontal,
                itemCount: actions.length,
                separatorBuilder: (_, __) => Container(width: 16),
                itemBuilder: (context, position) => BottomSheetAction(
                  actions[position]['text'],
                  icon: actions[position]['icon'],
                  backgroundColor: actions[position]['color'],
                  onTap: () {
                    actions[position]['action']();

                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _shouldShowErrorSignUpDialog(
    BuildContext context, {
    required SignUpState state,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state is SignUpErrorState) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Problemi durante la registrazione'),
            content: const Text('I dati forniti non sono corretti.'),
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

  void _shouldShowSuccessSignUpDialog(
    BuildContext context, {
    required SignUpState state,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state is SignedUpState) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Registrazione effettuata'),
            content: const Text(
                'La registrazione del tuo account è stata completata.'),
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
}
