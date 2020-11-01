import 'package:flutter_app/events-patient/patient_event.dart';



class DeletePatient extends PatientEvent {
  int patientIndex;

  DeletePatient(int index) {
    patientIndex = index;
  }
}