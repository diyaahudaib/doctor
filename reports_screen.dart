import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportsScreen extends StatefulWidget {
  final String patientId;

  const ReportsScreen({super.key, required this.patientId});

  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _reportController = TextEditingController();

  Future<void> _addReport() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('reports').add({
        'patientId': widget.patientId,
        'report': _reportController.text,
        'timestamp': Timestamp.now(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Report added successfully')),
      );
      _reportController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Reports for patient ${widget.patientId}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _reportController,
                    decoration: const InputDecoration(labelText: 'Enter report'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a report';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _addReport,
                    child: const Text('Add Report'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

