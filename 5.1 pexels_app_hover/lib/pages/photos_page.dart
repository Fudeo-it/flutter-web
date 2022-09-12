import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pexels_app/cubits/pexels_cubit.dart';
import 'package:pexels_app/models/photo.dart';
import 'package:pexels_app/widgets/app_drawer.dart';
import 'package:pexels_app/widgets/exception_widget.dart';
import 'package:pexels_app/widgets/grid_builder.dart';
import 'package:pexels_app/widgets/loading_widget.dart';
import 'package:pexels_app/widgets/photo_card.dart';
import 'package:pexels_app/widgets/responsive_builder.dart';

class PhotosPage extends StatelessWidget {
  final String title;

  const PhotosPage({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => PexelsCubit(
          pexelsRepository: context.read(),
        )..search(title),
        child: ResponsiveBuilder(builder: (context, deviceType) {
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            drawer: deviceType == DeviceType.phone ? const AppDrawer() : null,
            body: Row(
              children: [
                if (deviceType > DeviceType.phone) const AppDrawer(),
                _body(),
              ],
            ),
          );
        }),
      );

  Widget _body() => Expanded(
        child: BlocBuilder<PexelsCubit, PexelsState>(builder: (context, state) {
          if (state is PexelsError) {
            return const ExceptionWidget();
          } else if (state is PexelsLoaded) {
            return _adaptableBody(photos: state.photos);
          }

          return const LoadingWidget();
        }),
      );

  Widget _adaptableBody({
    required List<Photo> photos,
  }) =>
      GridBuilder(
        extraSmall: (context) => _listView(
          context,
          photos: photos,
        ),
        small: (context) => _gridView(
          context,
          photos: photos,
          width: 750,
        ),
        medium: (context) => _gridView(
          context,
          photos: photos,
          width: 1150,
          itemsPerRow: 3,
        ),
        large: (context) => _gridView(
          context,
          photos: photos,
          width: 1550,
          itemsPerRow: 4,
        ),
        extraLarge: (context) => _gridView(
          context,
          photos: photos,
          itemsPerRow: 5,
        ),
      );

  Widget _gridView(
    BuildContext context, {
    required List<Photo> photos,
    int itemsPerRow = 2,
    double width = 1950,
  }) =>
      Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: width,
          child: GridView.count(
            crossAxisCount: itemsPerRow,
            childAspectRatio: 500 / 250,
            children:
                photos.map((photo) => PhotoCard(photo)).toList(growable: false),
          ),
        ),
      );

  Widget _listView(
    BuildContext context, {
    required List<Photo> photos,
  }) =>
      ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final photo = photos[index];

          return PhotoCard(photo);
        },
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemCount: photos.length,
      );
}
