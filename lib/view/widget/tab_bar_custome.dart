import 'package:apps_daftar_hadir/view/widget/break_line.dart';
import 'package:apps_daftar_hadir/view/widget/card_border_commponent.dart';
import 'package:apps_daftar_hadir/view/widget/text_custome.dart';
import 'package:flutter/material.dart';
import 'package:apps_daftar_hadir/core/utils/color_utils.dart';
import 'package:google_fonts/google_fonts.dart';

class TabBarCardCustome extends StatefulWidget {
  final List<Widget>? tabbarView;
  final List<String>? tabbar;
  final Function(int)? onChange;
  const TabBarCardCustome({super.key, this.tabbarView, this.tabbar, this.onChange});

  @override
  State<TabBarCardCustome> createState() => _TabBarCardCustomeState();
}

class _TabBarCardCustomeState extends State<TabBarCardCustome> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabbar!.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          padding: const EdgeInsets.symmetric(vertical: 20),
          labelPadding: const EdgeInsets.symmetric(horizontal: 6),
          tabAlignment: TabAlignment.center,
          controller: _tabController,
          indicator: BoxDecoration(
            color: ColorPallate.transparentColor,
          ),
          labelColor: ColorPallate.whiteColor,
          unselectedLabelColor: ColorPallate.black50color,
          dividerColor: Colors.transparent,
          splashBorderRadius: BorderRadius.circular(12.0),
          indicatorSize: TabBarIndicatorSize.tab,
          isScrollable: true,
          tabs: List.generate(
            widget.tabbar!.length,
            (index) {
              return CardBorderCommponent(
                padding: const EdgeInsets.all(10),
                onTap: () {
                  setState(() {
                    _tabController.index = index;
                    widget.onChange!(_tabController.index);
                  });
                },
                colorBorder: index == _tabController.index
                    ? ColorPallate.transparentColor
                    : ColorPallate.primarycolor.withOpacity(0.08),
                color: index == _tabController.index
                    ? ColorPallate.primarycolor
                    : ColorPallate.primarycolor.withOpacity(0.04),
                child: TextCustome(
                  color: index == _tabController.index ? ColorPallate.whiteColor : ColorPallate.black50color,
                  text: widget.tabbar![index],
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              );
            },
          ),
        ),
        const BreakLine(
          height: 1,
          width: double.infinity,
          margin: EdgeInsets.zero,
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: widget.tabbarView ?? const [],
          ),
        ),
      ],
    );
  }
}

class TabBarBorderCustome extends StatefulWidget {
  final List<Widget>? tabbarView;
  final List<Widget>? tabbar;
  final int? initialIndex;
  const TabBarBorderCustome({super.key, this.tabbarView, this.tabbar, this.initialIndex});

  @override
  State<TabBarBorderCustome> createState() => _TabBarBorderCustomeState();
}

class _TabBarBorderCustomeState extends State<TabBarBorderCustome> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabbar!.length, vsync: this, initialIndex: widget.initialIndex ?? 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardBorderCommponent(
          padding: EdgeInsets.zero,
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              color: ColorPallate.primarycolor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            labelColor: ColorPallate.whiteColor,
            unselectedLabelColor: ColorPallate.black50color,
            dividerColor: Colors.transparent,
            splashBorderRadius: BorderRadius.circular(8.0),
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            tabs: widget.tabbar ?? const [],
          ),
        ),
        const BreakLine(
          height: 1,
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 20),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: widget.tabbarView ?? const [],
          ),
        ),
      ],
    );
  }
}
