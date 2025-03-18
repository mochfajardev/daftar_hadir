import 'package:apps_daftar_hadir/core/dto/event_dto.dart';
import 'package:apps_daftar_hadir/core/utils/color_utils.dart';
import 'package:apps_daftar_hadir/core/viewmodel/event_provider.dart';
import 'package:apps_daftar_hadir/view/widget/app_bar_page_commponent.dart';
import 'package:apps_daftar_hadir/view/widget/button_custome.dart';
import 'package:apps_daftar_hadir/view/widget/card_border_commponent.dart';
import 'package:apps_daftar_hadir/view/widget/form_custome.dart';
import 'package:apps_daftar_hadir/view/widget/text_custome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AcaraFormPage extends StatelessWidget {
  const AcaraFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBarPageCommponent(
      title: "Form Acara",
      body: Consumer<EventProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            child: Column(
              children: [
                TextFormCustome(
                  controller: provider.nameAcaraController,
                  labelText: "Nama Acara",
                  hintText: "Masukan Nama Acara",
                  keyboardType: TextInputType.name,
                ),
                TextFormCustome(
                  controller: provider.nameDivisiController,
                  labelText: "Divisi",
                  hintText: "Contoh : RT",
                ),
                TextFormCustome(
                  controller: provider.deskripsiAcaraController,
                  labelText: "deskripsi Acara",
                  hintText: "Masukan deskripsi Acara",
                  maxLines: 3,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormCustome(
                        controller: provider.divisiController,
                        labelText: "Divisi",
                        hintText: "Divisi",
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ButtonCustome(
                        value: true,
                        textTitle: "Tambah Divisi",
                        sizeText: 14,
                        onTap: () => provider.addDivisi(provider.divisiController.text),
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.divisiList.length,
                  itemBuilder: (context, index) {
                    final divisi = provider.divisiList[index];
                    return CardBorderCommponent(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              TextCustome(
                                text: "${index + 1} . ",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              TextCustome(
                                text: divisi,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () => provider.removeDivisi(index),
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
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Consumer<EventProvider>(builder: (context, provider, _) {
            return ButtonCustome(
              value: true,
              textTitle: "Simpan",
              padding: const EdgeInsets.all(16),
              onTap: () {
                final dto = EventDto(
                  name: provider.nameAcaraController.text,
                  nameDivisi: provider.nameDivisiController.text,
                  description: provider.deskripsiAcaraController.text,
                );
                provider.addEvent(context, dto);
              },
            );
          }),
        ],
      ),
    );
  }
}
