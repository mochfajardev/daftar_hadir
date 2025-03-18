import 'package:apps_daftar_hadir/core/utils/color_utils.dart';
import 'package:apps_daftar_hadir/core/viewmodel/event_provider.dart';
import 'package:apps_daftar_hadir/view/acara_page/acara_form.dart';
import 'package:apps_daftar_hadir/view/acara_page/acara_person_form.dart';
import 'package:apps_daftar_hadir/view/widget/app_bar_main_commponent.dart';
import 'package:apps_daftar_hadir/view/widget/button_custome.dart';
import 'package:apps_daftar_hadir/view/widget/card_border_commponent.dart';
import 'package:apps_daftar_hadir/view/widget/text_custome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    context.read<EventProvider>().getEvent();
  }

  @override
  Widget build(BuildContext context) {
    return AppBarMainCommponent(
      onRefresh: () async {
        context.read<EventProvider>().getEvent();
      },
      body: Column(
        children: [
          Expanded(
            child: Consumer<EventProvider>(
              builder: (context, provider, _) {
                return ListView.builder(
                  padding: const EdgeInsets.all(20),
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: provider.eventList?.length,
                  itemBuilder: (context, index) {
                    final event = provider.eventList?[index];
                    return CardBorderCommponent(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AcaraPersonForm(data: event),
                          ),
                        );
                      },
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextCustome(
                                  text: event?.name ?? '',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                                TextCustome(
                                  text: event?.description ?? '',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          GestureDetector(
                            onTap: () => provider.deleteEvent(event?.id ?? 0),
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: ColorPallate.primarycolor,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.close_rounded,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          ButtonCustome(
            value: true,
            textTitle: "Buat acara",
            padding: const EdgeInsets.all(16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AcaraFormPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
