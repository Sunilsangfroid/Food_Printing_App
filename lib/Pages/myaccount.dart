import 'package:flutter/material.dart';

class MyAccountPage extends StatefulWidget {
  @override
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
        title: Text('My Account'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.0),
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
                    child: Icon(Icons.camera_alt, size: 60),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            buildContainerWithLabel('Name', buildInputField(nameController)),
            buildContainerWithLabel('Email', buildInputField(emailController)),
            buildContainerWithLabel('Phone', buildInputField(phoneController)),
            SizedBox(height: 20.0),
            Divider(),
            buildContainerWithDropdown('Gender', [
              'Male',
              'Female',
            ], selectedGender, (value) {
              setState(() {
                selectedGender = value;
              });
            }),
            buildContainerWithLabel('Height (cm)', buildInputField(heightController)),
            buildContainerWithLabel('Weight (kg)', buildInputField(weightController)),
            buildContainerWithLabel('BMI', buildBMIField()),
            SizedBox(height: 20.0),
            Divider(),
            buildContainerWithLabel('Medical History', buildInputField(TextEditingController())), // Medical history input field
            SizedBox(height: 20.0),
            Divider(),
          ],
        ),
      ),
    );
  }

  Widget buildInputField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue), // Set boundary color to blue
        ),
      ),
    );
  }

  Widget buildContainerWithDropdown(
      String label, List<String> options, String selectedOption, Function onChanged) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          DropdownButtonFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue), // Set boundary color to blue
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
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          child,
        ],
      ),
    );
  }

  Widget buildBMIField() {
    return TextFormField(
      controller: TextEditingController(text: bmi.toStringAsFixed(2)),
      readOnly: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue), // Set boundary color to blue
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
    print('Choose image');
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
