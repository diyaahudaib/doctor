import 'package:flutter/material.dart';
import 'diary_screen.dart'; // Make sure to import DiaryScreen

class NavigationDrawer extends StatelessWidget {
  final VoidCallback? onProfilePressed;

  const NavigationDrawer({Key? key, this.onProfilePressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF6200EA),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Doctor Dashboard',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/doctor_icon.png'), // Replace with your image asset path
                ),
              ],
            ),
          ),
          _createDrawerItem(
            icon: Icons.dashboard,
            text: 'Dashboard',
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          _createDrawerItem(
            icon: Icons.people,
            text: 'Patients',
            onTap: () {
              Navigator.pushReplacementNamed(context, '/patients');
            },
          ),
          _createDrawerItem(
            icon: Icons.calendar_today,
            text: 'Appointments',
            onTap: () {
              Navigator.pushReplacementNamed(context, '/appointments');
            },
          ),
          _createDrawerItem(
            icon: Icons.book,
            text: 'Diary',
            onTap: () {
              Navigator.pushReplacementNamed(context, '/diary');
            },
          ),
          _createDrawerItem(
            icon: Icons.logout,
            text: 'Logout',
            onTap: () {
              _logout(context);
            },
          ),
          if (onProfilePressed != null)
            _createDrawerItem(
              icon: Icons.person,
              text: 'Profile',
              onTap: () {
                onProfilePressed!();
              },
            ),
        ],
      ),
    );
  }

  Widget _createDrawerItem({required IconData icon, required String text, required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon, color: Color(0xFF6200EA)),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text, style: TextStyle(fontSize: 18)),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  void _logout(BuildContext context) {
    // Perform any logout operations here (e.g., clearing user data)

    // Navigate to the login screen
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}
