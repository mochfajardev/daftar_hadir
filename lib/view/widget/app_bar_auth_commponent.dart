import 'package:apps_daftar_hadir/core/utils/color_utils.dart';
import 'package:apps_daftar_hadir/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

class AppBarAuthCommponent extends StatelessWidget {
  final Widget child1;
  final Widget child2;
  final bool hideButton;
  const AppBarAuthCommponent({
    super.key,
    required this.child1,
    required this.child2,
    this.hideButton = false,
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
          child: Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            children: [
              Container(
                height: 200,
                padding: EdgeInsets.only(top: SizeUtils.sizedTop(context) + 20, left: 20, right: 20),
                decoration: BoxDecoration(
                  color: ColorPallate.primarycolor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        hideButton
                            ? const SizedBox()
                            : InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: ColorPallate.whiteColor,
                                ),
                              ),
                        const SizedBox(),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      child: child1,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 200,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: ColorPallate.whiteColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20.0),
                    ),
                  ),
                  child: child2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
