import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../res/app_images.dart';
import '../../res/enum.dart';


class ImageView extends StatelessWidget {
  final String? url;
  final String? placeholder;
  final Color? color;
  final String? semanticsLabel;
  final double? height;
  final double? width;
  final ImageType type;
  final double? scale;
  final BoxFit? fit;
  final File? imageFile;
  final Widget? errorWidget;

  const ImageView.svg(
      this.url, {
        this.color,
        this.semanticsLabel,
        this.height,
        this.scale,
        this.fit,
        this.width,
        super.key,
      })  : type = ImageType.svg,
        placeholder = null,
        errorWidget = null,
        imageFile = null;

  const ImageView.network(
      this.url, {
        this.color,
        this.semanticsLabel,
        this.height,
        this.scale,
        this.fit,
        this.width,
        this.errorWidget,
        this.placeholder,
        super.key,
      })  : type = ImageType.network,
        imageFile = null;

  const ImageView.networkCached(
      this.url, {
        this.color,
        this.semanticsLabel,
        this.height,
        this.scale,
        this.fit,
        this.width,
        this.errorWidget,
        super.key,
      })  : type = ImageType.networkCached,
        placeholder = null,
        imageFile = null;

  const ImageView.asset(
      this.url, {
        this.color,
        this.semanticsLabel,
        this.height,
        this.scale,
        this.fit,
        this.width,
        super.key,
      })  : type = ImageType.asset,
        placeholder = null,
        errorWidget = null,
        imageFile = null;

  const ImageView.file(
      this.imageFile, {
        this.color,
        this.semanticsLabel,
        this.height,
        this.scale = 1,
        this.fit,
        this.width,
        super.key,
      })  : type = ImageType.file,
        placeholder = null,
        errorWidget = null,
        url = null;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ImageType.svg:
        return SvgPicture.asset(
          url!,
          semanticsLabel: semanticsLabel,
          height: height,
          width: width,
          fit: fit ?? BoxFit.contain,
          colorFilter: color != null
              ? ColorFilter.mode(
            color!,
            BlendMode.srcIn,
          )
              : null,
        );

      case ImageType.network:
        return FadeInImage.assetNetwork(
          placeholderScale: scale,
          fit: fit ?? BoxFit.cover,
          height: height,
          width: width,
          fadeInDuration: const Duration(milliseconds: 500),
          fadeInCurve: Curves.easeIn,
          placeholder: placeholder ?? AppImages.logo,
          image: url!,
          imageErrorBuilder: (context, error, stackTrace) {
            return errorWidget ?? _defaultError();
          },
        );

      case ImageType.networkCached:
        return CachedNetworkImage(
          imageUrl: url!,
          fit: fit ?? BoxFit.cover,
          height: height,
          width: width,
          fadeInDuration: const Duration(milliseconds: 500),
          fadeInCurve: Curves.easeIn,
          placeholder: (context, url) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          errorWidget: (context, url, error) {
            return errorWidget ?? _defaultError();
          },
        );

      case ImageType.asset:
        return Image.asset(
          url!,
          height: height,
          width: width,
          color: color,
          fit: fit,
          scale: scale,
          semanticLabel: semanticsLabel,
        );

      case ImageType.file:
        return Image.file(
          imageFile!,
          height: height,
          width: width,
          color: color,
          fit: fit,
          scale: scale??1.0,
          semanticLabel: semanticsLabel,
        );
    }
  }

  Widget _defaultError() {
    return const Center(
      child: Icon(
        Icons.image_not_supported_outlined,
        size: 30,
      ),
    );
  }
}