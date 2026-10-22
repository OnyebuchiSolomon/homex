import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homex/ui/global.dart';


class ProfileImage extends StatelessWidget {
  final dynamic url;
  final String? placeHolder;
  final String? hero;
  final double height;
  final double width;
  final double scale;
  final BoxFit fit;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry padding;
  final void Function()? onPressed;
  final String? fullName;
  final double fontSize;
  final bool cached;
  final bool isElevated;
  final Color? backgroundColor;
  const ProfileImage(
      this.url, {
        this.fullName,
        this.fontSize = 16.0,
        this.hero,
        this.height = 48,
        this.width = 48,
        this.scale = 1,
        this.placeHolder,
        this.margin,
        this.onPressed,
        this.fit = BoxFit.cover,
        this.padding = EdgeInsets.zero,
        this.isElevated = false,
        this.backgroundColor = AppColors.onPrimaryFixed,
        super.key,
      }) : cached = false;

  const ProfileImage.cached(
      this.url, {
        this.fullName,
        this.fontSize = 16.0,
        this.hero,
        this.height = 48,
        this.width = 48,
        this.scale = 1,
        this.placeHolder,
        this.margin,
        this.onPressed,
        this.fit = BoxFit.cover,
        this.padding = EdgeInsets.zero,
        this.isElevated = false,
        this.backgroundColor = AppColors.lightOutline,
        super.key,
      }) : cached = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: Container(
            margin: margin,
            padding: padding,
            decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  if (isElevated) ...[
                    BoxShadow(
                        color: Theme.of(context).shadowColor,
                        blurRadius: 5,
                        spreadRadius: 0.05),
                  ]
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: hero != null
                  ? Hero(tag: hero!, child: _buildImage())
                  : _buildImage(),
            )));
  }

  Widget _buildImage() {
    if (url is File) {
      return ImageView.file(
        url,
        fit: fit,
        height: height,
        width: width,
        scale: scale,
      );
    }
    if (cached) {
      return ImageView.networkCached(url,
          fit: fit,
          height: height,
          width: width,
          scale: scale,
          errorWidget: _buildError());
    }
    return ImageView.network(url,
        placeholder: AppImages.icon,
        fit: fit,
        height: height,
        width: width,
        scale: scale,
        errorWidget: _buildError());
  }

  Widget _buildError() => Builder(builder: (context) {
    if (fullName != null) {
      return Container(
          height: height,
          width: width,
          padding: const EdgeInsets.all(2.0),
          child: Center(
            child: Text(
              initials,
              maxLines: 1,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w700,
                color: AppColors.success,
              ),
            ),
          ));
    }
    return ImageView.svg(
      AppImages.icon,
      fit: fit,
      height: height,
      width: width,
      scale: scale,
    );
  });

  String get initials {
    String initial = '';
    try {
      fullName!.split(' ').forEach((name) {
        initial += name[0];
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return initial;
  }
}