import 'package:flutter/material.dart';
import 'package:pexels_app/models/photo.dart';

class PhotoCard extends StatelessWidget {
  final Photo photo;

  const PhotoCard(this.photo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.center,
        child: Card(
          child: Stack(
            children: [
              _photo,
              _caption,
            ],
          ),
        ),
      );

  Widget get _photo => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(photo.src.medium,
            width: 500, height: 250, fit: BoxFit.fitWidth),
      );

  Widget get _caption => Positioned(
        left: 0,
        bottom: 0,
        right: 0,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: ListTile(
            title: _alt,
            subtitle: _artist,
          ),
        ),
      );

  Widget get _alt => Text(
        photo.alt,
        style: const TextStyle(color: Colors.white),
      );

  Widget get _artist => Text(
        photo.photographer,
        style: const TextStyle(color: Colors.white),
      );
}
