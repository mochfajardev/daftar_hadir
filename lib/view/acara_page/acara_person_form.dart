import 'dart:io';

import 'package:apps_daftar_hadir/core/database/divisi_database.dart';
import 'package:apps_daftar_hadir/core/database/event_database.dart';
import 'package:apps_daftar_hadir/core/dto/person_dto.dart';
import 'package:apps_daftar_hadir/core/utils/color_utils.dart';
import 'package:apps_daftar_hadir/core/viewmodel/person_provider.dart';
import 'package:apps_daftar_hadir/view/acara_page/acara_person_detail.dart';
import 'package:apps_daftar_hadir/view/widget/app_bar_page_commponent.dart';
import 'package:apps_daftar_hadir/view/widget/break_line.dart';
import 'package:apps_daftar_hadir/view/widget/button_custome.dart';
import 'package:apps_daftar_hadir/view/widget/card_border_commponent.dart';
import 'package:apps_daftar_hadir/view/widget/form_custome.dart';
import 'package:apps_daftar_hadir/view/widget/select_component.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';

class AcaraPersonForm extends StatelessWidget {
  final EventDatabase? data;
  const AcaraPersonForm({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PersonProvider>(
      create: (context) => PersonProvider(),
      child: _AcaraPersonBody(data: data),
    );
  }
}

class _AcaraPersonBody extends StatefulWidget {
  final EventDatabase? data;
  const _AcaraPersonBody({this.data});

  @override
  State<_AcaraPersonBody> createState() => _AcaraPersonBodyState();
}

class _AcaraPersonBodyState extends State<_AcaraPersonBody> {
  @override
  void initState() {
    super.initState();
    context.read<PersonProvider>().getEvent(widget.data?.id ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return AppBarPageCommponent(
      title: "${widget.data?.name}",
      leading: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AcaraPersonDetail(
                data: widget.data,
              ),
            ),
          );
        },
        child: Icon(
          Icons.list,
          color: ColorPallate.black90color,
        ),
      ),
      body: Consumer<PersonProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                TextFormCustome(
                  controller: provider.namePersonController,
                  hintText: "Nama",
                  labelText: "Nama",
                  keyboardType: TextInputType.name,
                ),
                TextFormCustome(
                  controller: provider.nomorHpController,
                  hintText: "Nomor Handphone",
                  labelText: "Nomor Handphone",
                  keyboardType: TextInputType.number,
                ),
                SelectComponent(
                  hintText: "Pilih ${provider.eventData?.nameDivisi}",
                  value: provider.selectDivisi,
                  listItem: widget.data?.divisi.map((value) {
                    return DropdownMenuItem<DivisiDatabase>(
                      value: value,
                      onTap: () {
                        setState(() {
                          provider.selectDivisi = value;
                        });
                      },
                      child: Text(value.name),
                    );
                  }).toList(),
                  onChanged: (value) {},
                ),
                CardBorderCommponent(
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tanda Tangan",
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: ColorPallate.black90color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const BreakLine(
                        height: 1.6,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Builder(
                          builder: (context) {
                            if (provider.signatureImage != null) {
                              return Image.file(
                                provider.signatureImage ?? File(''),
                                width: double.infinity,
                                height: 200,
                              );
                            } else {
                              return Signature(
                                controller: provider.signatureController,
                                width: double.infinity,
                                height: 200,
                                backgroundColor: ColorPallate.greyBGcolor,
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      ButtonCustome(
                        value: true,
                        textTitle: "Ulangi",
                        onTap: () {
                          provider.signatureController.clear();
                          provider.signatureImage = null;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Consumer<PersonProvider>(
            builder: (context, provider, _) {
              return ButtonCustome(
                isLoading: provider.isLoading,
                value: provider.namePersonController.text.isNotEmpty &&
                    provider.nomorHpController.text.isNotEmpty &&
                    provider.selectDivisi != null,
                textTitle: "Simpan",
                padding: const EdgeInsets.all(16),
                onTap: () async {
                  await provider.saveSignature();

                  final dto = PersonDto(
                    name: provider.namePersonController.text,
                    signatureImage: provider.signatureImage,
                    nomorHp: provider.nomorHpController.text,
                    divisiId: provider.selectDivisi?.id,
                    eventId: widget.data?.id,
                  );

                  provider.addPerson(dto);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
