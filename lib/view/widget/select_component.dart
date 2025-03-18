import 'package:apps_daftar_hadir/core/utils/color_utils.dart';
import 'package:apps_daftar_hadir/view/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectComponent<T> extends StatelessWidget {
  final String? hintText;
  final T? value;
  final List<DropdownMenuItem<T>>? listItem;
  final bool readOnly;
  final Function(T?)? onChanged;
  final Function()? onTap;
  final bool loading;
  const SelectComponent({
    this.hintText,
    this.listItem,
    this.value,
    this.onChanged,
    super.key,
    this.readOnly = false,
    this.loading = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (loading) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: LoadingLine(),
        );
      }
      return Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ColorPallate.greyBGcolor.withOpacity(0.2),
          border: Border.all(
            color: value == null ? ColorPallate.greyBGcolor : ColorPallate.primarycolor.withOpacity(0.40),
            width: 1.6,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            isExpanded: true,
            icon: Icon(
              Icons.keyboard_arrow_down_sharp,
              color: Colors.grey[700],
            ),
            onTap: onTap,
            value: value,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w400,
              color: ColorPallate.black90color,
              fontSize: 14,
            ),
            hint: Text(
              hintText ?? '',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                color: ColorPallate.black50color,
                fontSize: 14,
              ),
            ),
            items: listItem,
            onChanged: readOnly ? null : onChanged,
          ),
        ),
      );
    });
  }
}
