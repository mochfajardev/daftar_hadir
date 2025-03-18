import 'package:apps_daftar_hadir/core/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';

class TextLoading extends StatelessWidget {
  final double? height;
  final double? width;
  const TextLoading({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200] as Color,
      highlightColor: Colors.grey[300] as Color,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorPallate.whiteColor,
        ),
        width: width,
      ),
    );
  }
}

class ImageLoading extends StatelessWidget {
  final double? radius;
  const ImageLoading({super.key, this.radius});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200] as Color,
      highlightColor: Colors.grey[300] as Color,
      child: CircleAvatar(
        radius: radius,
      ),
    );
  }
}

class LoadingLine extends StatelessWidget {
  const LoadingLine({super.key});

  @override
  Widget build(BuildContext context) {
    return  LinearProgressIndicator(
      minHeight: 8,
      color: ColorPallate.primarycolor,
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
    );
  }
}

class LoadingButton extends StatelessWidget {
  const LoadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.horizontalRotatingDots(
        color: ColorPallate.primarycolor,
        size: 34,
      ),
    );
  }
}
