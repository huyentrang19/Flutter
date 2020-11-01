
import 'package:flutter_app/model-patient/patient.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
//asynchronous lässt das Programm fertig deployen
// während es auf andere Operation wartet um zu erledigen
//Einige asynchronous Operationen sind:
// Daten über ein Netzwerk abrufen
// Eine Datenbank zu schreiben
// Daten aus einem File lesen
class DatabaseProvider {
  static const String TABLE_PATIENT = "patient";
  static const String COLUMN_ID = "id";
  static const String COLUMN_NAME = "name";
  static const String COLUMN_GEBURTSDATUM = "geburtsdatum";
  static const String COLUMN_ISGEHFAEHIG = "isGehfähig";
  static const String COLUMN_ATEMWEGFREQUENZKLEINER30 = "isAtemwegfrequenzkleiner30";
  static const String COLUMN_KREISLAUFKLEINER2 = "isKreislaufKleiner2";
  static const String COLUMN_SPONTANATMUNG = "isSpontanAtmung";
  static const String COLUMN_SPONTANATMUNGNACHDERATEMWEGSOEFFNUNG = "isSpontanAtmungNachDerAtemwegsoeffnung";
  static const String COLUMN_NEUROLOGIEAUFFORDERUNG = "isNeurologieAufforderung";
  static const String COLUMN_TRIAGEKATEGORIE ="triageKategorie";
  static const String COLUMN_VITALWERT = "vitalwert";
  static const String COLUMN_STANDORT = "standort";

//  Constructor
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  Database _database;

  Future <Database> get database async {
    print("database getter called");

    if (_database != null) {
      return _database;
    }

    _database = await createDatabase();

    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'patientDB.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        print("Creating patient table");

        await database.execute(
          "CREATE TABLE $TABLE_PATIENT ("
              "$COLUMN_ID INTEGER PRIMARY KEY,"
              "$COLUMN_NAME TEXT,"
              "$COLUMN_GEBURTSDATUM TEXT,"
              "$COLUMN_ISGEHFAEHIG INTEGER,"
              "$COLUMN_ATEMWEGFREQUENZKLEINER30 INTEGER,"
              "$COLUMN_KREISLAUFKLEINER2 INTEGER,"
              "$COLUMN_SPONTANATMUNG INTEGER,"
              "$COLUMN_SPONTANATMUNGNACHDERATEMWEGSOEFFNUNG INTEGER,"
              "$COLUMN_NEUROLOGIEAUFFORDERUNG  INTEGER,"
              "$COLUMN_TRIAGEKATEGORIE  TEXT,"
              "$COLUMN_VITALWERT TEXT,"
              "$COLUMN_STANDORT TEXT"

              ")",
        );
      },
    );
  }

  Future<List<Patient>> getPatients() async {
    final db = await database;

    var patients = await db
        .query(TABLE_PATIENT, columns: [COLUMN_ID, COLUMN_NAME, COLUMN_GEBURTSDATUM, COLUMN_ISGEHFAEHIG]);

    List<Patient> patientList = List<Patient>();

    patients.forEach((currentPatient) {
      Patient patient = Patient.fromMap(currentPatient);

      patientList.add(patient);
    });

    return patientList;
  }

  Future<Patient> insert(Patient patient) async {
    final db = await database;
    patient.id = await db.insert(TABLE_PATIENT, patient.toMap());
    return patient;
  }

  Future<int> delete(int id) async {
    final db = await database;

    return await db.delete(
      TABLE_PATIENT,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> update(Patient patient) async {
    final db = await database;

    return await db.update(
      TABLE_PATIENT,
      patient.toMap(),
      where: "id = ?",
      whereArgs: [patient.id],
    );
  }
}