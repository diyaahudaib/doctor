import 'package:flutter/material.dart';
import 'patient_list_screen.dart';
import 'medical_history_screen.dart';
import 'lab_results_screen.dart';
import 'medications_screen.dart';
import 'reports_screen.dart';

class PatientDetailScreen extends StatelessWidget {
  final Patient patient;

  const PatientDetailScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Name: ${patient.name}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Age: ${patient.age}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            const Spacer(), // Spacer to push buttons to the bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MedicalHistoryScreen(patientId: patient.id),
                          ),
                        );
                      },
                      backgroundColor: Colors.lightBlue,
                      child: const Icon(Icons.history),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LabResultsScreen(patientId: patient.id),
                          ),
                        );
                      },
                      backgroundColor: Colors.lightBlue,
                      child: const Icon(Icons.science),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MedicationsScreen(patientId: patient.id),
                          ),
                        );
                      },
                      backgroundColor: Colors.lightBlue,
                      child: const Icon(Icons.local_pharmacy),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReportsScreen(patientId: patient.id),
                          ),
                        );
                      },
                      backgroundColor: Colors.lightBlue,
                      child: const Icon(Icons.assignment),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
