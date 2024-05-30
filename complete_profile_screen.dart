import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CompleteProfileScreen extends StatefulWidget {
  final VoidCallback onProfileComplete;

  const CompleteProfileScreen({Key? key, required this.onProfileComplete}) : super(key: key);

  @override
  _CompleteProfileScreenState createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String phone;
  late String location;
  late String price;
  late String education;
  late String daysOff;

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
        title: const Text('Complete Profile'),
        backgroundColor: const Color(0xFF6200EA),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
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
              _buildTextFormField('Name', '', (value) => name = value!),
              _buildTextFormField('Phone Number', '', (value) => phone = value!, validator: _validatePhoneNumber),
              _buildTextFormField('Location', '', (value) => location = value!),
              _buildTextFormField('Price', '', (value) => price = value!),
              _buildTextFormField('Education', '', (value) => education = value!),
              _buildTextFormField('Days Off', '', (value) => daysOff = value!),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    widget.onProfileComplete();
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6200EA), // button color
                ),
                child: const Text('Complete Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(String label, String initialValue, Function(String?) onSave, {String? Function(String?)? validator}) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF6200EA)),
        ),
      ),
      onSaved: onSave,
      validator: validator,
    );
  }
}
