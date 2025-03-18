import 'package:apps_daftar_hadir/core/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextCustome extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final EdgeInsetsGeometry? padding;
  const TextCustome({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow, this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: fontSize ?? 16,
          fontWeight: fontWeight ?? FontWeight.w600,
          color: color ?? ColorPallate.black70color,
        ),
        textAlign: textAlign ?? TextAlign.left,
        maxLines: maxLines,
        overflow: overflow,
      ),
    );
  }
}
