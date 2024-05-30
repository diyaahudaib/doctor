import 'package:flutter/material.dart';
import 'DoctorHomeScreen.dart';
import 'DoctorRegisterScreen.dart';
import 'profile_screen.dart';
import 'patient_list_screen.dart';
import 'appointment_screen.dart'; // Import the AppointmentScreen
import 'DoctorLoginScreen.dart';
import 'diary_screen.dart'; // Import the DiaryScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const DoctorLoginScreen(),
        '/register': (context) => const DoctorRegisterScreen(),
        '/home': (context) => DoctorHomeScreen(),
        '/profile': (context) => ProfileScreen(),
        '/patients': (context) => const PatientListScreen(),
        '/appointments': (context) => const AppointmentScreen(), // Add route for Appointments
        '/diary': (context) => DiaryScreen(), // Add route for Diary
      },
    );
  }
}
