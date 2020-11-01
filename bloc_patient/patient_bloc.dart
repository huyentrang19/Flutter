import 'package:flutter_app/events-patient/add_patient.dart';
import 'package:flutter_app/events-patient/delete_patient.dart';
import 'package:flutter_app/events-patient/patient_event.dart';
import 'package:flutter_app/events-patient/set_patient.dart';
import 'package:flutter_app/events-patient/update_patient.dart';
import 'package:flutter_app/model-patient/patient.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientBloc extends Bloc<PatientEvent, List<Patient>> {
  @override
  List<Patient> get initialState => List<Patient>();

  @override
  Stream<List<Patient>> mapEventToState(PatientEvent event) async* {
    if (event is SetPatient) {
      yield event.patientList;
    } else if (event is AddPatient) {
      List<Patient> newState = List.from(state);
      if (event.newPatient != null) {
        newState.add(event.newPatient);
      }
      yield newState;
    } else if (event is DeletePatient) {
      List<Patient> newState = List.from(state);
      newState.removeAt(event.patientIndex);
      yield newState;
    } else if (event is UpdatePatient) {
      List<Patient> newState = List.from(state);
      newState[event.patientIndex] = event.newPatient;
      yield newState;
    }
  }
}