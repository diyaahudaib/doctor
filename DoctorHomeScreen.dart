import 'package:flutter/material.dart';
import 'navigation_drawer.dart' as custom_drawer;

class DoctorHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Doctor Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF6200EA),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Notifications button pressed')),
              );
            },
          ),
        ],
      ),
      drawer: custom_drawer.NavigationDrawer(
        onProfilePressed: () {
          Navigator.pushReplacementNamed(context, '/profile');
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, Doctor!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildDashboardCard(
                    title: 'Appointments',
                    icon: Icons.calendar_today,
                    color: Color(0xFF03DAC6),
                    onPressed: () {
                      Navigator.pushNamed(context, '/appointments');
                    },
                  ),
                  _buildDashboardCard(
                    title: 'Patients',
                    icon: Icons.person,
                    color: Color(0xFFFF0266),
                    onPressed: () {
                      Navigator.pushNamed(context, '/patients');
                    },
                  ),
                  _buildDashboardCard(
                    title: 'Messages',
                    icon: Icons.message,
                    color: Color(0xFF6200EA),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Messages button pressed')),
                      );
                    },
                  ),
                  _buildDashboardCard(
                    title: 'Settings',
                    icon: Icons.settings,
                    color: Color(0xFFFFA000),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Settings button pressed')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 50,
                color: Colors.white,
              ),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
