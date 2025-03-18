import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:apps_daftar_hadir/core/database/event_database.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class PersonExcelProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void onLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<File?> generateExcel({EventDatabase? data}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    onLoading(true);
    try {
      //Create a Excel document.

      //Creating a workbook.
      final Workbook workbook = Workbook();
      // final format = DateFormat.yMMMMEEEEd("id_ID");
      //Accessing via index
      final Worksheet sheet = workbook.worksheets[0];

      // Enable calculation for worksheet.
      sheet.enableSheetCalculations();

      sheet.getRangeByName('A2:E3').merge();
      sheet.getRangeByIndex(2, 1).setText(data?.name);

      final List<String> headers = ["NO", "Nama", "Nomor HP", data?.nameDivisi ?? "Divisi", "Tanda Tangan"];
      for (int i = 0; i < headers.length; i++) {
        final Range cell = sheet.getRangeByIndex(4, i + 1);
        cell.setText(headers[i]);

        // Menambahkan border ke header
        cell.cellStyle.borders.all.lineStyle = LineStyle.thin;
        cell.cellStyle.borders.all.color = '#000000'; // Warna hitam
        cell.cellStyle.bold = true;
        cell.cellStyle.hAlign = HAlignType.center;
        cell.cellStyle.vAlign = VAlignType.center;
      }

      var row = 5;
      var no = 1;

      for (var item in data!.persons) {
        final File imageFile = File(item.sigantureImage);
        final Uint8List bytes = await imageFile.readAsBytes();

        sheet.getRangeByIndex(row, 1).setText("$no");
        sheet.getRangeByIndex(row, 2).setText(item.name);
        sheet.getRangeByIndex(row, 3).setText(item.nomorHp);
        sheet.getRangeByIndex(row, 4).setText(item.divisi.target?.name);
        final pic = sheet.pictures.addStream(row, 5, bytes);
        pic.height = 52;
        pic.width = 52;

        for (int col = 1; col <= 5; col++) {
          final Range cell = sheet.getRangeByIndex(row, col);
          cell.cellStyle.borders.all.lineStyle = LineStyle.thin;
          cell.cellStyle.borders.all.color = '#000000';
        }

        row++;
        no++;
      }
      var baris = row - 1;
      // sheet.getRangeByIndex(row, 2).setText("TOTAL");
      // sheet.getRangeByIndex(row, 5).setFormula('=SUM(E5:E$baris)');
      // sheet.getRangeByIndex(row, 5).setFormula('=SUM("${CurrencyFormat.convertToRupiah(int.parse("E5:E$baris"), 2)}")');

      final Range range1 = sheet.getRangeByName('A2:A$baris');
      range1.cellStyle.hAlign = HAlignType.center;
      range1.cellStyle.vAlign = VAlignType.center;

      // final Range range2 = sheet.getRangeByName('A5:B$baris');
      // range2.cellStyle.hAlign = HAlignType.center;
      // range2.cellStyle.vAlign = VAlignType.center;

      const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
      Random rnd = Random();
      String getRandomString(int length) =>
          String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));

      //Save and launch the excel.
      final List<int> bytes = workbook.saveAsStream();
      // File('/storage/emulated/0/Download/biro_users_${getRandomString(10)}.xlsx').writeAsBytes(bytes);

      final file =
          File('/storage/emulated/0/Download/absen_${data.name}${getRandomString(10)}.xlsx').writeAsBytes(bytes);
      //Dispose the document.
      workbook.dispose();

      onLoading(false);
      return file;
    } catch (e) {
      onLoading(false);
      debugPrint(e.toString());
      return null;
    }
  }
}
