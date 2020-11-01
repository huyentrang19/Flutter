import 'package:flutter/material.dart';
import 'package:flutter_app/events-patient/delete_patient.dart';
import 'package:flutter_app/events-patient/set_patient.dart';
import 'package:flutter_app/patient_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_patient/patient_bloc.dart';

import 'database/database_provide.dart';
import 'model-patient/patient.dart';


class PatientList extends StatefulWidget {
  const PatientList({Key key}) : super(key: key);

  @override
  _PatientListState createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  @override
  void initState() {
    super.initState();

    DatabaseProvider.db.getPatients().then(
          (patientList) {
        BlocProvider.of<PatientBloc>(context).add(SetPatient(patientList));
      },
    );
  }

  showPatientDialog(BuildContext context, Patient patient, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(patient.name),
        content: Text("ID ${patient.id}"),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PatientForm(patient: patient, patientIndex: index),
              ),
            ),
            child: Text("Update"),
          ),
          FlatButton(
            onPressed: () => DatabaseProvider.db.delete(patient.id).then((_) {
              BlocProvider.of<PatientBloc>(context).add(
                DeletePatient(index),
              );
              Navigator.pop(context);
            }),
            child: Text("Delete"),
          ),
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Building entire patient list scaffold");
    return Scaffold(
      appBar: AppBar(title: Text("PatientList")),
      body: Container(
        child: BlocConsumer<PatientBloc, List<Patient>>(
          builder: (context, patientList) {
            return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                print("patientList: $patientList");

                Patient patient = patientList[index];
                return ListTile(
                    title: Text(patient.name, style: TextStyle(fontSize: 30)),
                    subtitle: Text(
                      "Geburtsdatum: ${patient.geburtsdatum}\nIsGehfaehig: ${patient.isGehfaehig}",
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () => showPatientDialog(context, patient, index));
              },
              itemCount: patientList.length,
              separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.black),
            );
          },
          listener: (BuildContext context, patientList) {},
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => PatientForm()),
        ),
      ),
    );
  }
}