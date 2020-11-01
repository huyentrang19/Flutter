
import 'patient_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_patient/patient_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PatientBloc>(
      create: (context) => PatientBloc(),
      child: MaterialApp(
        title: 'Sqflite Tutorial',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: PatientList(),
      ),
    );
  }
}