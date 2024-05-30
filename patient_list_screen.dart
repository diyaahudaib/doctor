import 'package:flutter/material.dart';
import 'navigation_drawer.dart' as custom_drawer;
import 'patient_detail_screen.dart';

class Patient {
  final String name;
  final int age;
  final String id;

  Patient({required this.name, required this.age, required this.id});
}

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({super.key});

  @override
  _PatientListScreenState createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  final List<Patient> _patients = [
    Patient(name: 'John Doe', age: 30, id: '1'),
    Patient(name: 'Jane Smith', age: 25, id: '2'),
    Patient(name: 'Bob Johnson', age: 45, id: '3'),
  ];

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<Patient> filteredPatients = _patients
        .where((patient) =>
            patient.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patients'),
      ),
      drawer: const custom_drawer.NavigationDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredPatients.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredPatients[index].name),
                  subtitle: Text('Age: ${filteredPatients[index].age}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PatientDetailScreen(patient: filteredPatients[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
