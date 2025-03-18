import 'package:apps_daftar_hadir/core/data/base_database.dart';
import 'package:apps_daftar_hadir/core/database/divisi_database.dart';
import 'package:apps_daftar_hadir/core/database/event_database.dart';
import 'package:apps_daftar_hadir/core/database/person_database.dart';
import 'package:get_it/get_it.dart';
import 'package:objectbox/objectbox.dart';

final locator = GetIt.instance;

Future<void> configureInjectionDB() async {
  final store = await ObjectBox.create();
  locator.registerSingleton<Store>(store);

  locator.registerLazySingleton<Box<EventDatabase>>(() => store.box<EventDatabase>());
  locator.registerLazySingleton<Box<PersonDatabase>>(() => store.box<PersonDatabase>());
  locator.registerLazySingleton<Box<DivisiDatabase>>(() => store.box<DivisiDatabase>());
}