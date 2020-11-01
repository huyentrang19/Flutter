import 'package:flutter_app/events-patient/patient_event.dart';
import 'package:flutter_app/model-patient/patient.dart';


class SetPatient extends PatientEvent {
  List<Patient> patientList;

  SetPatient(List<Patient> patient) {
    patientList = patient;
  }
}