import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:apps_daftar_hadir/core/utils/color_utils.dart';
import 'package:apps_daftar_hadir/view/widget/text_custome.dart';

class BuilderCommponent<T> extends StatelessWidget {
  final bool isLoading;
  final bool isLoadingNext;
  final List<T>? listData;
  final EdgeInsetsGeometry? padding;
  final Widget? builderLoading;
  final ScrollController? controller;
  final Widget? Function(BuildContext, int) builderSuccess;
  const BuilderCommponent({
    super.key,
    required this.listData,
    required this.builderSuccess,
    this.isLoading = false,
    this.isLoadingNext = false,
    this.builderLoading,
    this.controller,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (listData == null && !isLoading) {
          return ListView.builder(
            shrinkWrap: true,
            padding: padding ?? EdgeInsets.zero,
            itemCount: 4,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: builderLoading,
              );
            },
          );
        }

        if (listData == null && isLoading) {
          return ListView.builder(
            shrinkWrap: true,
            padding: padding ?? EdgeInsets.zero,
            itemCount: 4,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: builderLoading,
              );
            },
          );
        }

        if (listData!.isEmpty) {
          return const Center(
            child: TextCustome(
              text: "Data Kosong",
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                padding: padding ?? EdgeInsets.zero,
                itemCount: listData?.length ?? 0,
                controller: controller,
                itemBuilder: builderSuccess,
              ),
            ),
            isLoadingNext
                ? Center(
                    child: LoadingAnimationWidget.horizontalRotatingDots(
                      color: ColorPallate.redcolor,
                      size: 34,
                    ),
                  )
                : const SizedBox(),
          ],
        );
      },
    );
  }
}

class BuilderHorizontalCommponent<T> extends StatelessWidget {
  final bool isLoading;
  final bool isLoadingNext;
  final List<T>? listData;
  final Widget? builderLoading;
  final ScrollController? controller;
  final Widget? Function(BuildContext, int) builderSuccess;
  const BuilderHorizontalCommponent({
    super.key,
    required this.listData,
    required this.builderSuccess,
    this.isLoading = false,
    this.isLoadingNext = false,
    this.builderLoading,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (listData == null && !isLoading) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: SizedBox(
              child: builderLoading,
            ),
          );
        }

        if (listData == null && isLoading) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: SizedBox(
              child: builderLoading,
            ),
          );
        }

        if (listData!.isEmpty) {
          return Center(
            child: TextCustome(
              text: "Data Kosong",
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          );
        }

        return MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: listData?.length ?? 0,
                  controller: controller,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: builderSuccess,
                ),
              ),
              isLoadingNext
                  ? Center(
                      child: LoadingAnimationWidget.horizontalRotatingDots(
                        color: ColorPallate.redcolor,
                        size: 34,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
