import 'package:apps_daftar_hadir/core/database/divisi_database.dart';
import 'package:apps_daftar_hadir/core/database/event_database.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class PersonDatabase {
  @Id()
  int id;
  String name;
  String sigantureImage;
  String nomorHp;

  final divisi = ToOne<DivisiDatabase>();
  final event = ToOne<EventDatabase>();

  PersonDatabase({
    this.id = 0,
    required this.name,
    required this.nomorHp,
    required this.sigantureImage,
  });
}
