import 'package:apps_daftar_hadir/core/database/divisi_database.dart';
import 'package:apps_daftar_hadir/core/database/event_database.dart';
import 'package:apps_daftar_hadir/core/dto/event_dto.dart';
import 'package:apps_daftar_hadir/injector_db.dart';
import 'package:apps_daftar_hadir/view/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';

class EventProvider extends ChangeNotifier {
  final _acaraDatabase = locator<Box<EventDatabase>>();
  final _divisDatabase = locator<Box<DivisiDatabase>>();

  TextEditingController nameAcaraController = TextEditingController();
  TextEditingController nameDivisiController = TextEditingController();
  TextEditingController deskripsiAcaraController = TextEditingController();
  TextEditingController divisiController = TextEditingController();

  final List<String> _divisiList = [];
  List<String> get divisiList => _divisiList;

  List<EventDatabase>? _eventList;
  List<EventDatabase>? get eventList => _eventList;

  void addDivisi(String divisi) {
    _divisiList.add(divisi);
    divisiController.clear();
    notifyListeners();
  }

  void removeDivisi(int divisi) {
    _divisiList.removeAt(divisi);
    notifyListeners();
  }

  void addEvent(BuildContext context, EventDto dto) async {
    try {
      final data = EventDatabase(
        name: dto.name,
        nameDivisi: dto.nameDivisi,
        description: dto.description,
      );

      final eventId = _acaraDatabase.put(data);
      data.id = eventId;

      for (var i = 0; i < _divisiList.length; i++) {
        final datas = _divisiList[i];
        final divisi = DivisiDatabase(name: datas);

        divisi.acara.target = data;
        _divisDatabase.put(divisi);

        if (_divisiList.length - 1 == i) {
          clear();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
            (_) => false,
          );
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getEvent() async {
    try {
      _eventList = await _acaraDatabase.getAllAsync();
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void deleteEvent(int index) async {
    try {
      _acaraDatabase.remove(index);
      getEvent();
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void clear() {
    nameAcaraController.clear();
    nameDivisiController.clear();
    deskripsiAcaraController.clear();
    _divisiList.clear();
    notifyListeners();
  }
}
