import 'package:flutter/material.dart';

class MedicalHistoryScreen extends StatelessWidget {
  final String patientId;

  const MedicalHistoryScreen({super.key, required this.patientId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical History'),
      ),
      body: Center(
        child: Text('Medical history for patient $patientId'),
      ),
    );
  }
}
