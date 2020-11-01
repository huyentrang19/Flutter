import 'package:flutter_app/database/database_provide.dart';

class Patient {
  int id;
  String name;
  String geburtsdatum;
  bool isGehfaehig;


  Patient({this.id, this.name, this.geburtsdatum, this.isGehfaehig});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.COLUMN_NAME: name,
      DatabaseProvider.COLUMN_GEBURTSDATUM: geburtsdatum,
      DatabaseProvider.COLUMN_ISGEHFAEHIG: isGehfaehig ? 1 : 0,

    };

    if (id != null) {
      map[DatabaseProvider.COLUMN_ID] = id;
    }

    return map;
  }

  Patient.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.COLUMN_ID];
    name = map[DatabaseProvider.COLUMN_NAME];
    geburtsdatum = map[DatabaseProvider.COLUMN_GEBURTSDATUM];
    isGehfaehig = map[DatabaseProvider.COLUMN_ISGEHFAEHIG] == 1;

  }
}