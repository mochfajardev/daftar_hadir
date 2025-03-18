import 'package:apps_daftar_hadir/core/utils/color_utils.dart';
import 'package:apps_daftar_hadir/core/utils/size_utils.dart';
import 'package:apps_daftar_hadir/view/widget/break_line.dart';
import 'package:flutter/material.dart';

showCustomModalBottomSheet(BuildContext context, {Widget? child}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: ColorPallate.whiteColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    builder: (context) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.only(bottom: SizeUtils.sizedInsetsBottom(context)),
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            const BreakLine(
              margin: EdgeInsets.only(top: 10),
              height: 6,
              width: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: child,
            ),
          ],
        ),
      );
    },
  );
}
