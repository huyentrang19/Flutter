
import 'package:flutter_app/events-patient/patient_event.dart';
import 'package:flutter_app/model-patient/patient.dart';




class AddPatient extends PatientEvent {
  Patient newPatient;

  AddPatient(Patient patient) {
    newPatient = patient;
  }
}
