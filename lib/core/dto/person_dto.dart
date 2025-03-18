import 'dart:io';

class PersonDto {
  String? name;
  String? nomorHp;
  int? divisiId;
  int? eventId;

  File? signatureImage;

  PersonDto({this.name, this.signatureImage, this.divisiId, this.nomorHp, this.eventId});
}
