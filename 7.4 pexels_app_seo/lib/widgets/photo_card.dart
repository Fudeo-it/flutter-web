import 'package:flutter/material.dart';
import 'package:pexels_app/models/photo.dart';
import 'package:seo_renderer/seo_renderer.dart';

class PhotoCard extends StatefulWidget {
  final Photo photo;
  final VoidCallback? onTap;

  const PhotoCard(this.photo, {this.onTap, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PhotoCardState();
}

class _PhotoCardState extends State<PhotoCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) => Semantics(
        label:
            'A photo of a ${widget.photo.alt} taken by ${widget.photo.photographer}',
        child: ExcludeSemantics(
          child: Align(
            alignment: Alignment.center,
            child: Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                onHover: _updateHoverState,
                onTap: widget.onTap,
                child: Stack(
                  children: [
                    _photo,
                    _caption,
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget get _photo => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: AnimatedScale(
          scale: _hovered ? 1.2 : 1.0,
          duration: const Duration(milliseconds: 250),
          child: ImageRenderer(
            alt: widget.photo.alt,
            src: widget.photo.src.medium,
            child: Image.network(
              widget.photo.src.medium,
              width: 500,
              height: 250,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
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

  Widget get _alt => TextRenderer(
        text: widget.photo.alt,
        child: Text(
          widget.photo.alt,
          style: const TextStyle(color: Colors.white),
        ),
      );

  Widget get _artist => TextRenderer(
        text: widget.photo.photographer,
        child: Text(
          widget.photo.photographer,
          style: const TextStyle(color: Colors.white),
        ),
      );

  void _updateHoverState(bool hovered) => setState(() => _hovered = hovered);
}
