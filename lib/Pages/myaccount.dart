import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  String selectedGender = 'Male'; // Default selected gender
  double bmi = 0.0;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with default values
    nameController.text = 'Name';
    emailController.text = 'example@example.com';
    phoneController.text = '+91';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Align(
              alignment: Alignment.bottomRight,
              // Centering the button
              child: ElevatedButton(
                onPressed: () {
                  print('Saved Name: $nameController.text');
                  print(
                      'Saved Email-id: $emailController.text');
                  print(
                      'Saved Phone_number: $phoneController.text');
                },
                // Apply TextStyle with color black to the button text
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),

            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _chooseImage, // Function to choose image
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                    ),
                    child: const Icon(Icons.camera_alt, size: 60),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            buildContainerWithLabel('Name', buildInputField(nameController)),
            buildContainerWithLabel('Email', buildInputField(emailController)),
            buildContainerWithLabel('Phone', buildInputField(phoneController)),
            const SizedBox(height: 20.0),
            const Divider(),
            buildContainerWithDropdown(
                'Gender',
                [
                  'Male',
                  'Female',
                ],
                selectedGender, (value) {
              setState(() {
                selectedGender = value;
              });
            }),
            buildContainerWithLabel(
                'Height (cm)', buildInputField(heightController)),
            buildContainerWithLabel(
                'Weight (kg)', buildInputField(weightController)),
            buildContainerWithLabel('BMI', buildBMIField()),
            const SizedBox(height: 20.0),
            const Divider(),
            buildContainerWithLabel(
                'Medical History',
                buildInputField(
                    TextEditingController())), // Medical history input field
            const SizedBox(height: 20.0),
            const Divider(),
          ],
        ),
      ),
    );
  }

  Widget buildInputField(TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1), // Shadow color
            spreadRadius: 2, // Spread radius
            blurRadius: 5, // Blur radius
            offset: const Offset(0, 3), // Offset in x and y direction
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.blue), // Set boundary color to blue
          ),
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
                borderSide: BorderSide(
                    color: Colors.blue), // Set boundary color to blue
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

  Widget buildBMIField() {
    return TextFormField(
      controller: TextEditingController(text: bmi.toStringAsFixed(2)),
      readOnly: true,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderSide:
              BorderSide(color: Colors.blue), // Set boundary color to blue
        ),
      ),
    );
  }

  void _calculateBMI() {
    double height = double.tryParse(heightController.text) ?? 0.0;
    double weight = double.tryParse(weightController.text) ?? 0.0;
    if (height > 0 && weight > 0) {
      double heightInMeters = height / 100;
      setState(() {
        bmi = weight / (heightInMeters * heightInMeters);
      });
    }
  }

  void _chooseImage() {
    // Function to choose an image
    // Implement image picker functionality here
    if (kDebugMode) {
      print('Choose image');
    }
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }
}
