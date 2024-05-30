import 'package:flutter/material.dart';

class LabResultsScreen extends StatelessWidget {
  final String patientId;

  const LabResultsScreen({super.key, required this.patientId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lab Results',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF6200EA),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lab results for patient $patientId',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            // Example lab result card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Icon(Icons.insert_drive_file, color: Color(0xFF6200EA)),
                title: Text('Blood Test'),
                subtitle: Text('Date: 2024-05-29\nStatus: Completed'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to detailed lab result screen
                },
              ),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Icon(Icons.insert_drive_file, color: Color(0xFF6200EA)),
                title: Text('Urine Test'),
                subtitle: Text('Date: 2024-05-20\nStatus: Completed'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to detailed lab result screen
                },
              ),
            ),
            // Add more cards for other lab results
          ],
        ),
      ),
    );
  }
}
