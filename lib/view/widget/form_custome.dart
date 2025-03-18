import 'dart:async';

import 'package:apps_daftar_hadir/core/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormCustome extends StatefulWidget {
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obsureText;
  final String? hintText;
  final String? labelText;
  final bool passwordFail;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool readOnly;
  final Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final double? vertical;
  final double? sizeCard;
  final int? maxLines;
  final bool debounce;
  const TextFormCustome({
    super.key,
    this.controller,
    this.suffixIcon,
    this.obsureText = false,
    this.hintText,
    this.passwordFail = false,
    this.prefixIcon,
    this.onChanged,
    this.keyboardType,
    this.readOnly = false,
    this.inputFormatters,
    this.onTap,
    this.labelText,
    this.vertical,
    this.sizeCard,
    this.maxLines,
    this.debounce = false,
  });

  @override
  State<TextFormCustome> createState() => _TextFormCustomeState();
}

class _TextFormCustomeState extends State<TextFormCustome> {
  Timer? debounceTimer;

  @override
  void dispose() {
    if (widget.debounce) {
      widget.controller?.dispose();
      debounceTimer?.cancel();
    }
    super.dispose();
  }

  void onSearchChanged(String query) {
    if (widget.debounce) {
      if (debounceTimer?.isActive ?? false) {
        debounceTimer!.cancel();
      }

      debounceTimer = Timer(const Duration(milliseconds: 500), () {
        widget.onChanged!(query);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // height: widget.sizeCard ?? 62,
          margin: EdgeInsets.symmetric(vertical: widget.vertical ?? 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorPallate.greyBGcolor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: widget.controller!.text.isEmpty
                  ? ColorPallate.greyBGcolor
                  : ColorPallate.primarycolor.withOpacity(0.40),
              width: 1.6,
            ),
          ),
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.obsureText,
            keyboardType: widget.keyboardType,
            readOnly: widget.readOnly,
            inputFormatters: widget.inputFormatters,
            decoration: InputDecoration(
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              hintText: widget.hintText,
              labelText: widget.labelText,
              border: InputBorder.none,
              fillColor: ColorPallate.strokeColor,
              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              labelStyle: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: ColorPallate.black50color,
              ),
              hintStyle: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: widget.passwordFail ? ColorPallate.redcolor : ColorPallate.black70color,
              ),
            ),
            onTap: widget.onTap,
            onChanged: (value) {
              if (widget.debounce) {
                onSearchChanged(value);
              } else {
                widget.onChanged!(value);
              }
            },
            maxLines: widget.maxLines ?? 1,
          ),
        ),
        widget.passwordFail
            ? Text(
                "*Password berbeda, mohon masukkan dengan benar!",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  color: ColorPallate.redcolor,
                  fontSize: 10,
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
