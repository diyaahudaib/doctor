import 'package:flutter/material.dart';
import 'navigation_drawer.dart' as custom_drawer;

class Appointment {
  final String patientName;
  final String dateTime;
  final String description;

  Appointment({required this.patientName, required this.dateTime, required this.description});
}

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  final List<Appointment> _appointments = [
    Appointment(patientName: 'John Doe', dateTime: '2024-05-26 10:00 AM', description: 'Regular checkup'),
    Appointment(patientName: 'Jane Smith', dateTime: '2024-05-27 11:00 AM', description: 'Follow-up'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diary'),
      ),
      drawer: const custom_drawer.NavigationDrawer(),
      body: ListView.builder(
        itemCount: _appointments.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_appointments[index].patientName),
            subtitle: Text('${_appointments[index].dateTime}\n${_appointments[index].description}'),
            isThreeLine: true,
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                _editAppointment(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addAppointment,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addAppointment() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AppointmentDetailScreen(onSave: (appointment) {
          setState(() {
            _appointments.add(appointment);
          });
        }),
      ),
    );
  }

  void _editAppointment(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AppointmentDetailScreen(
          appointment: _appointments[index],
          onSave: (appointment) {
            setState(() {
              _appointments[index] = appointment;
            });
          },
        ),
      ),
    );
  }
}

class AppointmentDetailScreen extends StatefulWidget {
  final Appointment? appointment;
  final Function(Appointment) onSave;

  const AppointmentDetailScreen({super.key, this.appointment, required this.onSave});

  @override
  _AppointmentDetailScreenState createState() => _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  late String patientName;
  late String dateTime;
  late String description;

  @override
  void initState() {
    super.initState();
    patientName = widget.appointment?.patientName ?? '';
    dateTime = widget.appointment?.dateTime ?? '';
    description = widget.appointment?.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                initialValue: patientName,
                decoration: const InputDecoration(labelText: 'Patient Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the patient name';
                  }
                  return null;
                },
                onSaved: (value) {
                  patientName = value!;
                },
              ),
              TextFormField(
                initialValue: dateTime,
                decoration: const InputDecoration(labelText: 'Date and Time'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the date and time';
                  }
                  return null;
                },
                onSaved: (value) {
                  dateTime = value!;
                },
              ),
              TextFormField(
                initialValue: description,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  description = value!;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveAppointment,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveAppointment() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final appointment = Appointment(patientName: patientName, dateTime: dateTime, description: description);
      widget.onSave(appointment);
      Navigator.pop(context);
    }
  }
}
