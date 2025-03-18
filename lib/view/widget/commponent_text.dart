import 'package:apps_daftar_hadir/core/utils/color_utils.dart';
import 'package:apps_daftar_hadir/view/widget/text_custome.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommponentText extends StatelessWidget {
  final String? title;
  final String? content;
  final bool value;
  const CommponentText({super.key, this.title, this.content, this.value = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "",
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: ColorPallate.black90color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          content ?? "",
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: ColorPallate.black50color,
          ),
        ),
        const SizedBox(height: 8),
        Divider(color: value ? ColorPallate.greyBGcolor : Colors.transparent),
      ],
    );
  }
}

class CommponentText2 extends StatelessWidget {
  final String? title;
  final String? content;
  final bool value;
  const CommponentText2({super.key, this.title, this.content, this.value = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextCustome(
          padding: const EdgeInsets.only(top: 10),
          text: title ?? "",
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: ColorPallate.black50color,
        ),
        const SizedBox(height: 4),
        Text(
          content ?? "",
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: ColorPallate.black90color,
          ),
        ),
        const SizedBox(height: 8),
        Divider(color: value ? ColorPallate.greyBGcolor : Colors.transparent),
      ],
    );
  }
}
