import 'dart:io';

import 'package:apps_daftar_hadir/core/database/event_database.dart';
import 'package:apps_daftar_hadir/core/viewmodel/person_excel_provider.dart';
import 'package:apps_daftar_hadir/core/viewmodel/person_provider.dart';
import 'package:apps_daftar_hadir/view/widget/app_bar_page_commponent.dart';
import 'package:apps_daftar_hadir/view/widget/button_custome.dart';
import 'package:apps_daftar_hadir/view/widget/card_border_commponent.dart';
import 'package:apps_daftar_hadir/view/widget/text_custome.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:provider/provider.dart';

class AcaraPersonDetail extends StatelessWidget {
  final EventDatabase? data;
  const AcaraPersonDetail({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PersonProvider()),
        ChangeNotifierProvider(create: (context) => PersonExcelProvider()),
      ],
      child: _AcaraPersonDetailBody(data: data),
    );
  }
}

class _AcaraPersonDetailBody extends StatefulWidget {
  final EventDatabase? data;
  const _AcaraPersonDetailBody({this.data});

  @override
  State<_AcaraPersonDetailBody> createState() => _AcaraPersonDetailBodyState();
}

class _AcaraPersonDetailBodyState extends State<_AcaraPersonDetailBody> {
  @override
  void initState() {
    super.initState();
    context.read<PersonProvider>().getPersonList(widget.data?.id ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return AppBarPageCommponent(
      title: "Daftar Hadir",
      body: Consumer<PersonProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: provider.personList?.length ?? 0,
            itemBuilder: (context, index) {
              final event = provider.personList?[index];
              return CardBorderCommponent(
                margin: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // _rowCustome(title: "Nama", value: event?.name),
                    // _rowCustome(title: "Dari", value: event?.divisi.target?.name),
                    // _rowCustome(title: "Nomor", value: event?.nomorHp),
                    Row(
                      spacing: 10,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextCustome(
                              text: "Nama",
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            TextCustome(
                              text: "Dari",
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            TextCustome(
                              text: "Nomor Hp",
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextCustome(
                              text: ":\t\t${event?.name}",
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            TextCustome(
                              text: ":\t\t${event?.divisi.target?.name}",
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            TextCustome(
                              text: ":\t\t${event?.nomorHp}",
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Center(
                      child: Image.file(
                        File(event!.sigantureImage),
                        width: 160,
                        height: 160,
                      ),
                    ),
                    ButtonCustome(
                      value: true,
                      textTitle: "Hapus",
                      onTap: () => provider.deletePerson(event.id, widget.data?.id ?? 0),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Consumer2<PersonExcelProvider, PersonProvider>(
            builder: (context, provider, providerEvent,_) {
              return ButtonCustome(
                isLoading: provider.isLoading,
                value: true,
                textTitle: "Save",
                padding: const EdgeInsets.all(16),
                onTap: () async {
                  final result = await provider.generateExcel(data: providerEvent.personList?.first.event.target);
                  if (result != null) {
                    OpenFilex.open(result.path);
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
