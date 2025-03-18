import 'package:apps_daftar_hadir/core/utils/color_utils.dart';
import 'package:flutter/material.dart';

class CardBorderCommponent extends StatelessWidget {
  final Function()? onTap;
  final Widget? child;
  final Color? color;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? borderRadius;
  final Color? colorBorder;
  const CardBorderCommponent({
    super.key,
    this.onTap,
    this.child,
    this.color,
    this.margin,
    this.padding,
    this.borderRadius,
    this.width,
    this.colorBorder,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: ColorPallate.primarycolor.withOpacity(0.2),
      borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
      child: Container(
        padding: padding ?? const EdgeInsets.all(20),
        margin: margin,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
          border: Border.all(
            width: 1.5,
            color: colorBorder ?? ColorPallate.greyBGcolor,
          ),
        ),
        child: child,
      ),
    );
  }
}

class CardCommponent extends StatelessWidget {
  final Function()? onTap;
  final Widget? child;
  final Color? color;
  final double? borderRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  const CardCommponent({super.key, this.onTap, this.child, this.color, this.margin, this.padding, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
      child: Container(
        margin: margin,
        padding: padding ?? const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color ?? ColorPallate.whiteColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
        ),
        child: child,
      ),
    );
  }
}
