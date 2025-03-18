import 'package:apps_daftar_hadir/core/utils/color_utils.dart';
import 'package:flutter/material.dart';

class BreakLine extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  final EdgeInsetsGeometry? margin;
  const BreakLine({super.key, this.height, this.color, this.margin, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 20),
      height: height ?? 5,
      width: width,
      color: color ?? ColorPallate.greyBGcolor,
    );
  }
}