import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:social_network/blocs/consent/consent_bloc.dart';
import 'package:social_network/cubits/auth/auth_cubit.dart';
import 'package:social_network/repositories/consent_repository.dart';
import 'package:social_network/repositories/user_repository.dart';
import 'package:social_network/services/auth_service.dart';
import 'package:social_network/services/image_picker_service.dart';

part 'blocs.dart';
part 'providers.dart';
part 'repositories.dart';

class DependencyInjector extends StatelessWidget {
  final Widget child;

  const DependencyInjector({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => _Providers(
        child: _Repositories(
          child: _Blocs(
            child: child,
          ),
        ),
      );
}
