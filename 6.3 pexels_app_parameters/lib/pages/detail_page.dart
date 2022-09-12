import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pexels_app/cubits/photo/photo_cubit.dart';
import 'package:pexels_app/models/photo.dart';
import 'package:pexels_app/widgets/exception_widget.dart';
import 'package:pexels_app/widgets/loading_widget.dart';

class DetailPage extends StatelessWidget {
  final int id;

  const DetailPage(
    this.id, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => PhotoCubit(
          pexelsRepository: context.read(),
        )..photo(id),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Details'),
          ),
          body: _body,
        ),
      );

  Widget get _body => SizedBox(
        width: double.maxFinite,
        child: BlocBuilder<PhotoCubit, PhotoState>(builder: (context, state) {
          if (state is PhotoError) {
            return const ExceptionWidget();
          } else if (state is PhotoLoaded) {
            return _photo(state.photo);
          }

          return const LoadingWidget();
        }),
      );

  Widget _photo(Photo photo) => Padding(
        padding: const EdgeInsets.all(32),
        child: Image.network(
          photo.src.large2x,
          fit: BoxFit.fitWidth,
        ),
      );
}
