import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:console_bit/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DetailScreen extends StatelessWidget {
  final String imageUrl;

  const DetailScreen({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Hero(
          tag: 'hero',
          child: InteractiveViewer(
            panEnabled: false, // Set it to false
            boundaryMargin: const EdgeInsets.all(100),
            minScale: 0.5,
            maxScale: 2,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CachedNetworkImage(
                memCacheHeight: 900,
                memCacheWidth: 900,
                fit: BoxFit.cover,
                imageUrl: imageUrl,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: getScreeWidth(100),
                    height: getScreeWidth(100),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                errorWidget: (context, url, error) => Image.asset(
                    'assets/images/image_placeholder.jpg',
                    fit: BoxFit.cover),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
