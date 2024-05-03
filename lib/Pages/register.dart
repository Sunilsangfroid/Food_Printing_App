// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController =
      TextEditingController(text: FirebaseAuth.instance.currentUser!.email);
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController medicalHistoryController =
      TextEditingController();

  String selectedGender = 'Male';
  String selectedCountryCode = '+91';
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Registration Form'),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Complete Your Profile',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey),
                ),
                child: selectedImage != null
                    ? ClipOval(
                        child: Image.file(
                          selectedImage!,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Icon(
                        Icons.person,
                        size: 60,
                      ),
              ),
            ),
            const SizedBox(height: 20.0),
            buildContainerWithLabel(
              'Name',
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            buildContainerWithLabel(
              'Email',
              TextFormField(
                controller: emailController,
                readOnly: true,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            buildContainerWithLabel(
              'Phone',
              Row(
                children: [
                  buildCountryCodeDropdown(),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: buildInputField(phoneController,
                        inputType: TextInputType.phone),
                  ),
                ],
              ),
            ),
            buildContainerWithLabel(
              'Date of Birth',
              GestureDetector(
                onTap: _pickDateOfBirth,
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: dobController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Select Date',
                    ),
                  ),
                ),
              ),
            ),
            buildContainerWithDropdown(
              'Gender',
              ['Male', 'Female', 'Other'],
              selectedGender,
              (value) {
                setState(() {
                  selectedGender = value;
                });
              },
            ),
            buildContainerWithLabel(
              'Height (cm)',
              buildInputField(heightController,
                  inputType: TextInputType.number),
            ),
            buildContainerWithLabel(
              'Weight (kg)',
              buildInputField(weightController,
                  inputType: TextInputType.number),
            ),
            buildContainerWithLabel(
              'Medical History*',
              buildMedicalHistoryField(medicalHistoryController),
            ),
            const SizedBox(height: 20.0),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: _register,
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                ),
                child: const Text('Register'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCountryCodeDropdown() {
    return DropdownButton<String>(
      value: selectedCountryCode,
      onChanged: (String? value) {
        if (value != null) {
          setState(() {
            selectedCountryCode = value;
          });
        }
      },
      items: <String>['+91', '+92', '+1', '+44', '+61']
          .map<DropdownMenuItem<String>>((String value) {
        String countryCode = value.substring(1); // Remove the '+' sign
        return DropdownMenuItem<String>(
          value: value,
          child: Row(
            children: [
              Image.asset(
                'assets/images/flags/${countryCode.toLowerCase()}.png', // Use asset path directly
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 8.0),
              Text(value),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget buildInputField(TextEditingController controller,
      {required TextInputType inputType}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget buildContainerWithDropdown(String label, List<String> options,
      String selectedOption, Function onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          DropdownButtonFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
            value: selectedOption,
            items: options.map((option) {
              return DropdownMenuItem(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (newValue) {
              onChanged(newValue);
            },
          ),
        ],
      ),
    );
  }

  Widget buildMedicalHistoryField(TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget buildContainerWithLabel(String label, Widget child) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          child,
        ],
      ),
    );
  }

  void _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickDateOfBirth() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue, // Color for the selected day
              onPrimary: Colors.white, // Text color for the selected day
              surface: Colors.white, // Background color of the calendar
              onSurface: Colors.black, // Default text color
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        dobController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  void _register() {
    if (_isFormValid()) {
      // Perform registration logic here
      // You can access form field values using controllers
      print('Registration successful!');

      // Show a snackbar to indicate successful registration
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Registration successful!',
            style: TextStyle(color: Colors.green),
          ),
        ),
      );

      // Navigate to the home screen after registration
      Navigator.pushReplacementNamed(
          context, '/home'); // Replace '/home' with your home screen route
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please fill all sections',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
    }
  }

  bool _isFormValid() {
    return nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        dobController.text.isNotEmpty &&
        heightController.text.isNotEmpty &&
        weightController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        medicalHistoryController.text.isNotEmpty;
  }
}
