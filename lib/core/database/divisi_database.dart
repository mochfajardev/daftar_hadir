
import 'package:apps_daftar_hadir/core/database/event_database.dart';
import 'package:apps_daftar_hadir/core/database/person_database.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class DivisiDatabase {
  @Id()
  int id;
  String name;

  final acara = ToOne<EventDatabase>();
  @Backlink()
  final person = ToMany<PersonDatabase>();

  DivisiDatabase({
    this.id = 0,
    required this.name,
  });
}