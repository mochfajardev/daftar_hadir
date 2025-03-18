import 'dart:io';

import 'package:apps_daftar_hadir/core/database/divisi_database.dart';
import 'package:apps_daftar_hadir/core/database/event_database.dart';
import 'package:apps_daftar_hadir/core/database/person_database.dart';
import 'package:apps_daftar_hadir/core/dto/person_dto.dart';
import 'package:apps_daftar_hadir/core/utils/save_image.dart';
import 'package:apps_daftar_hadir/injector_db.dart';
import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:signature/signature.dart';

class PersonProvider extends ChangeNotifier {
  SignatureController signatureController = SignatureController();
  final _personDatabase = locator<Box<PersonDatabase>>();
  final _divisDatabase = locator<Box<DivisiDatabase>>();
  final _eventDatabase = locator<Box<EventDatabase>>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void onLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  TextEditingController namePersonController = TextEditingController();
  TextEditingController nomorHpController = TextEditingController();
  File? signatureImage;

  DivisiDatabase? _selectDivisi;
  DivisiDatabase? get selectDivisi => _selectDivisi;

  EventDatabase? _eventData;
  EventDatabase? get eventData => _eventData;

  List<PersonDatabase>? _personList;
  List<PersonDatabase>? get personList => _personList;

  set selectDivisi(DivisiDatabase? value) {
    _selectDivisi = value;
    notifyListeners();
  }

  void addPerson(PersonDto dto) async {
    await Future.delayed(const Duration(milliseconds: 500));
    onLoading(true);
    try {
      final divisi = _divisDatabase.get(dto.divisiId ?? 0);

      if (divisi != null) {
        final event = divisi.acara.target;

        final data = PersonDatabase(
          name: dto.name ?? "",
          sigantureImage: dto.signatureImage!.path,
          nomorHp: dto.nomorHp ?? "",
        );

        data.divisi.target = divisi;
        data.event.target = event;

        final personId = await _personDatabase.putAsync(data);
        data.id = personId;

        event?.persons.add(data);
        _eventDatabase.put(event!);
      }
      clear();
    } catch (e) {
      onLoading(false);
      debugPrint(e.toString());
    }
    onLoading(false);
  }

  void getPersonList(int id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    onLoading(true);
    try {
      final result = await _eventDatabase.getAsync(id);

      _personList = result?.persons.toList();

      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      onLoading(false);
    }
    onLoading(false);
  }

  void getEvent(int id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    onLoading(true);
    try {
      _eventData = _eventDatabase.get(id);
      notifyListeners();
    } catch (e) {
      onLoading(false);
      debugPrint(e.toString());
    }
    onLoading(false);
  }

  void deletePerson(int id, int eventId) async {
    try {
      // _personDatabase.remove(id);
      final result = _eventDatabase.get(eventId);

      if (result != null) {
        final perosn = result.persons.firstWhere((p) => p.id == id);

        result.persons.remove(perosn);
        _eventDatabase.put(result);
        getPersonList(eventId);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void initSignature() async {
    signatureController =
        SignatureController(penStrokeWidth: 6, exportBackgroundColor: Colors.white, exportPenColor: Colors.black);
  }

  void clearSignature() {
    signatureController.clear();
    signatureImage = null;
    notifyListeners();
  }

  Future<void> saveSignature() async {
    final bytes = await signatureController.toPngBytes();
    signatureImage = await SaveImage().convertMultiImg(bytes!);
    notifyListeners();
  }

  void clear() {
    namePersonController.clear();
    selectDivisi = null;
    signatureController.clear();
    nomorHpController.clear();
    signatureImage = null;
    notifyListeners();
  }
}
