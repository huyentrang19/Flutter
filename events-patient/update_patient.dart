
import 'package:flutter_app/events-patient/patient_event.dart';
import 'package:flutter_app/model-patient/patient.dart';



class UpdatePatient extends PatientEvent {
  Patient newPatient;
  int patientIndex;

  UpdatePatient(int index, Patient patient) {
    newPatient = patient;
    patientIndex = index;
  }
}