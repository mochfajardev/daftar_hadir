import 'package:apps_daftar_hadir/core/utils/color_utils.dart';
import 'package:apps_daftar_hadir/core/utils/size_utils.dart';
import 'package:apps_daftar_hadir/view/widget/break_line.dart';
import 'package:apps_daftar_hadir/view/widget/text_custome.dart';
import 'package:flutter/material.dart';

class AppBarMainCommponent extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget body;
  final Widget? floatingActionButton;
  const AppBarMainCommponent({
    super.key,
    required this.onRefresh,
    required this.body,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: ColorPallate.whiteColor,
      backgroundColor: ColorPallate.primarycolor,
      child: Scaffold(
        backgroundColor: ColorPallate.whiteColor,
        body: Center(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: SizeUtils.sizedHeight(context),
              maxWidth: SizeUtils.sizedDeviceRatio,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: SizeUtils.sizedTop(context) + 20, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // InkWell(
                      //   onTap: () => WidgetAlert.showCoomingSoon(context),
                      //   child: Container(
                      //     padding: const EdgeInsets.all(8.0),
                      //     decoration: BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       border: Border.all(
                      //         color: ColorPallate.grey70color,
                      //         width: 2,
                      //       ),
                      //     ),
                      //     child: SvgPicture.asset(AssetsUtils.svgListMenu, height: 28),
                      //   ),
                      // ),
                      const SizedBox(),
                      // Image.asset(AssetsUtils.imgApps, height: 36),
                      TextCustome(
                        text: "Apps Daftar Hadir",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: ColorPallate.black90color,
                      ),
                      const SizedBox(),
                      // InkWell(
                      //   onTap: () => WidgetAlert.showCoomingSoon(context),
                      //   child: Container(
                      //     padding: const EdgeInsets.all(8.0),
                      //     decoration: BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       border: Border.all(
                      //         color: ColorPallate.grey70color,
                      //         width: 2,
                      //       ),
                      //     ),
                      //     child: SvgPicture.asset(AssetsUtils.svgNotifikasi, height: 28),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                const BreakLine(
                  margin: EdgeInsets.only(top: 20),
                  height: 2,
                  width: double.infinity,
                ),
                Expanded(
                  child: body,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}
