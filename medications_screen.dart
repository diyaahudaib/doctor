import 'package:flutter/material.dart';

class MedicationsScreen extends StatelessWidget {
  final String patientId;

  const MedicationsScreen({super.key, required this.patientId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medications'),
      ),
      body: Center(
        child: Text('Medications for patient $patientId'),
      ),
    );
  }
}
