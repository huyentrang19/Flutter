
import 'package:flutter/material.dart';
import 'package:flutter_app/events-patient/add_patient.dart';
import 'package:flutter_app/events-patient/update_patient.dart';
import 'package:flutter_app/model-patient/patient.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_patient/patient_bloc.dart';
import 'database/database_provide.dart';



class PatientForm extends StatefulWidget {
  final Patient patient;
  final int patientIndex;

  PatientForm({this.patient, this.patientIndex});

  @override
  State<StatefulWidget> createState() {
    return PatientFormState();
  }
}

class PatientFormState extends State<PatientForm> {
  String _name;
  String _geburtsdatum;
  bool _isGehfaehig = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      initialValue: _name,
      decoration: InputDecoration(labelText: 'Name'),
      maxLength: 15,
      style: TextStyle(fontSize: 28),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }
        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildGeburtsdatum() {
    return TextFormField(
      initialValue: _geburtsdatum,
      decoration: InputDecoration(labelText: 'Geburtsdatum'),
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 28),
      validator: (String value) {

          if (value.isEmpty) {
            return 'Name is Required';
          }
          return null;
        },
      onSaved: (String value) {
        _geburtsdatum = value;
      },
    );
  }

  Widget _buildIsGehfaehig() {
    return SwitchListTile(
      title: Text("Gehfähig?", style: TextStyle(fontSize: 20)),
      value: _isGehfaehig,
      onChanged: (bool newValue) => setState(() {
        _isGehfaehig = newValue;
      }),
    );
  }



  @override
  void initState() {
    super.initState();
    if (widget.patient != null) {
      _name = widget.patient.name;
      _geburtsdatum = widget.patient.geburtsdatum;
      _isGehfaehig = widget.patient.isGehfaehig;

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Patient Form")),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildName(),
              _buildGeburtsdatum(),
              SizedBox(height: 20),
              _buildIsGehfaehig(),
              SizedBox(height: 20),


              widget.patient == null
                  ? RaisedButton(
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }

                  _formKey.currentState.save();

                  Patient patient = Patient(
                    name: _name,
                    geburtsdatum: _geburtsdatum,
                    isGehfaehig: _isGehfaehig,

                  );

                  DatabaseProvider.db.insert(patient).then(
                        (storedPatient) => BlocProvider.of<PatientBloc>(context).add(
                      AddPatient(storedPatient),
                    ),
                  );

                  Navigator.pop(context);
                },
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: Text(
                      "Update",
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                    onPressed: () {
                      if (!_formKey.currentState.validate()) {
                        print("form");
                        return;
                      }

                      _formKey.currentState.save();

                      Patient patient = Patient(
                        name: _name,
                        geburtsdatum: _geburtsdatum,
                        isGehfaehig: _isGehfaehig,

                      );

                      DatabaseProvider.db.update(widget.patient).then(
                            (storedPatient) => BlocProvider.of<PatientBloc>(context).add(
                          UpdatePatient(widget.patientIndex, patient),
                        ),
                      );

                      Navigator.pop(context);
                    },
                  ),
                  RaisedButton(
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),

                ],
              ),
            ],
          ),

        ),
      ),
    );
  }
}
