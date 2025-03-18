import 'package:apps_daftar_hadir/core/database/divisi_database.dart';
import 'package:apps_daftar_hadir/core/database/person_database.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class EventDatabase {
  @Id()
  int id;
  String name;
  String nameDivisi;
  String description;
  DateTime date;

  @Backlink()
  final divisi = ToMany<DivisiDatabase>();
  @Backlink()
  final persons = ToMany<PersonDatabase>();

  EventDatabase({
    this.id = 0,
    required this.name,
    required this.description,
    required this.nameDivisi,
    DateTime? date,
  }) : date = date ?? DateTime.now();
}
