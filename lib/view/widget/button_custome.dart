import 'package:apps_daftar_hadir/core/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ButtonCustome extends StatelessWidget {
  final Function()? onTap;
  final String? textTitle;
  final Color? color;
  final Color? colorText;
  final double? sizeText;
  final bool value;
  final bool isLoading;
  final EdgeInsetsGeometry? padding;
  const ButtonCustome({
    super.key,
    this.onTap,
    this.textTitle,
    this.value = false,
    this.color,
    this.colorText,
    this.isLoading = false,
    this.sizeText,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (isLoading) {
          return Center(
            child: LoadingAnimationWidget.horizontalRotatingDots(
              color: ColorPallate.primarycolor,
              size: 34,
            ),
          );
        } else {
          return Padding(
            padding: padding ?? EdgeInsets.zero,
            child: Material(
              color: value ? color ?? ColorPallate.primarycolor : ColorPallate.grey20color,
              borderRadius: BorderRadius.circular(8.0),
              child: InkWell(
                onTap: value ? onTap : null,
                borderRadius: BorderRadius.circular(8.0),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      textTitle ?? '',
                      style: GoogleFonts.inter(
                        fontSize: sizeText ?? 16,
                        fontWeight: FontWeight.w600,
                        color: colorText ?? (value ? ColorPallate.whiteColor : ColorPallate.black50color),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class ButtonBorderCustome extends StatelessWidget {
  final Function()? onTap;
  final String? textTitle;
  final double? sizeText;
  final Color? color;
  final Color? colorText;
  final String? icon;
  final EdgeInsetsGeometry? padding;
  const ButtonBorderCustome({
    super.key,
    this.onTap,
    this.textTitle,
    this.color,
    this.colorText,
    this.sizeText,
    this.icon,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: ColorPallate.greyBGcolor, width: 1.5),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon != null
                    ? Image.asset(
                        icon!,
                        width: 24,
                        height: 24,
                        color: colorText ?? ColorPallate.primarycolor,
                      )
                    : const SizedBox(),
                SizedBox(width: icon != null ? 10 : 0),
                Text(
                  textTitle ?? '',
                  style: GoogleFonts.inter(
                    fontSize: sizeText ?? 16,
                    fontWeight: FontWeight.w600,
                    color: colorText ?? ColorPallate.primarycolor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
