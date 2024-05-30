import 'package:flutter/material.dart';
import 'navigation_drawer.dart' as custom_drawer;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, Key? key1});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;

  String name = "Dr. John Doe";
  String phone = "123-456-7890";
  String location = "123 Medical Street, City";
  String price = "\$100 per hour";
  String education = "MD, PhD";
  String daysOff = "Saturday, Sunday";

  File? _profileImage;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _profileImage = File(pickedFile.path);
      }
    });
  }

  String? _validatePhoneNumber(String? value) {
    RegExp regex = RegExp(r'^\+9627[789]\d{7}$');
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    } else if (!regex.hasMatch(value)) {
      return 'Please enter a valid Jordanian phone number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF6200EA),
      ),
      drawer: const custom_drawer.NavigationDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isEditing ? _buildEditForm() : _buildProfileView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isEditing = !_isEditing;
          });
        },
        backgroundColor: Color(0xFF6200EA),
        child: Icon(_isEditing ? Icons.check : Icons.edit),
      ),
    );
  }

  Widget _buildProfileView() {
    return ListView(
      children: [
        Center(
          child: CircleAvatar(
            radius: 50,
            backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
            child: _profileImage == null ? const Icon(Icons.person, size: 50) : null,
          ),
        ),
        const SizedBox(height: 20),
        _buildProfileDetail('Name', name),
        _buildProfileDetail('Phone', phone),
        _buildProfileDetail('Location', location),
        _buildProfileDetail('Price', price),
        _buildProfileDetail('Education', education),
        _buildProfileDetail('Days Off', daysOff),
      ],
    );
  }

  Widget _buildProfileDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditForm() {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Center(
            child: GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                child: _profileImage == null ? const Icon(Icons.person, size: 50) : null,
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildTextFormField('Name', name, (value) {
            name = value ?? name;
          }),
          _buildTextFormField('Phone Number', phone, (value) {
            phone = value ?? phone;
          }, validator: _validatePhoneNumber),
          _buildTextFormField('Location', location, (value) {
            location = value ?? location;
          }),
          _buildTextFormField('Price', price, (value) {
            price = value ?? price;
          }),
          _buildTextFormField('Education', education, (value) {
            education = value ?? education;
          }),
          _buildTextFormField('Days Off', daysOff, (value) {
            daysOff = value ?? daysOff;
          }),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                setState(() {
                  _isEditing = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile Updated')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF6200EA), // button color
            ),
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField(String label, String initialValue, Function(String?) onSave, {String? Function(String?)? validator}) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFF6200EA)),
        ),
      ),
      onSaved: onSave,
      validator: validator,
    );
  }
}
