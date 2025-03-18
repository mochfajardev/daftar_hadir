import 'package:apps_daftar_hadir/core/utils/color_utils.dart';
import 'package:apps_daftar_hadir/core/utils/size_utils.dart';
import 'package:apps_daftar_hadir/view/widget/break_line.dart';
import 'package:apps_daftar_hadir/view/widget/text_custome.dart';
import 'package:flutter/material.dart';

class AppBarPageCommponent extends StatelessWidget {
  final Widget body;
  final String? title;
  final Widget? bottomNavigationBar;
  final Widget? leading;
  final bool hideButton;
  const AppBarPageCommponent({
    super.key,
    required this.body,
    this.title,
    this.hideButton = false,
    this.bottomNavigationBar,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Row(
                      children: [
                        hideButton
                            ? const SizedBox()
                            : InkWell(
                                onTap: () => Navigator.pop(context),
                                child:
                                    Icon(Icons.arrow_back_ios_new_rounded, color: ColorPallate.black90color, size: 30),
                              ),
                        const SizedBox(width: 20),
                        TextCustome(
                          text: title ?? '',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    SizedBox(child: leading),
                  ],
                ),
              ),
              const BreakLine(
                margin: EdgeInsets.only(top: 20),
                height: 1,
                width: double.infinity,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: body,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: SizeUtils.sizedDeviceRatio,
            child: bottomNavigationBar,
          ),
        ],
      ),
    );
  }
}
