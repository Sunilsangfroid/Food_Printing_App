import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:itrm_screen/main.dart' show myApp;
import 'package:google_sign_in/google_sign_in.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController medicalHistoryController = TextEditingController();
  String selectedGender = 'Male';
  double bmi = 0.0;
  User? user;
  String selectedCountryCode = '+91';

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    nameController.text = 'Name';
    emailController.text = user!.email!;
    phoneController.text = '';
    heightController.addListener(_calculateBMI);
    weightController.addListener(_calculateBMI);
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
              child: ElevatedButton(
                onPressed: () {
                  _saveAccount();
                },
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
                  onTap: _chooseImage,
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
            buildContainerWithLabel(
                'Name', buildInputField(nameController, inputType: TextInputType.text)),
            buildContainerWithLabel(
                'Email', buildInputField(emailController, inputType: TextInputType.emailAddress)),
            buildContainerWithLabel(
              'Phone',
              Row(
                children: [
                  buildCountryCodeDropdown(),
                  const SizedBox(width: 8.0),
                  Expanded(child: buildInputField(phoneController, inputType: TextInputType.phone)),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            const Divider(),
            buildContainerWithDropdown(
                'Gender', ['Male', 'Female', 'Other'], selectedGender,
                (value) {
              setState(() {
                selectedGender = value;
              });
            }),
            buildContainerWithLabel('Height (cm)',
                buildInputField(heightController, inputType: TextInputType.number)),
            buildContainerWithLabel('Weight (kg)',
                buildInputField(weightController, inputType: TextInputType.number)),
            buildContainerWithLabel('BMI', buildBMIField()),
            const SizedBox(height: 20.0),
            const Divider(),
            buildContainerWithLabel(
                'Medical History',
                buildMedicalHistoryField(
                    medicalHistoryController)),
            const SizedBox(height: 20.0),
            const Divider(),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    switch (user?.providerData[0].providerId) {
                      case 'password':
                        await FirebaseAuth.instance.signOut();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Signed out successfully.'),
                          ),
                        );
                        Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/", (route) => false);
                        break;
                      case 'google.com':
                        await FirebaseAuth.instance.signOut();
                        await GoogleSignIn().signOut();
                        print(FirebaseAuth.instance.currentUser);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Signed out successfully.'),
                          ),
                        );
                        Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/", (route) => false);
                        break;
                    }
                  } on FirebaseAuthException catch (e) {
                    print(e);
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text("Sign Out"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
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
        setState(() {
          selectedCountryCode = value!;
        });
      },
      items: <String>['+91', '+1', '+44', '+61']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
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
        onChanged: (value) {
          // Only update nameController text while typing
          if (controller == nameController) {
            setState(() {
              controller.text = value;
            });
          }
        },
        inputFormatters: inputType == TextInputType.text
            ? <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z]*$')),
              ]
            : <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9@.]*$')),
              ],
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        validator: (value) {
          if (inputType == TextInputType.emailAddress && !value!.endsWith('@gmail.com')) {
            return 'Email must end with @gmail.com';
          }
          return null;
        },
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
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
      ),
    );
  }

  bool isNumeric(String? value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
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
          borderSide: BorderSide(color: Colors.blue),
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
    if (kDebugMode) {
      print('Choose image');
    }
  }

  void _saveAccount() {
  print('Saved Name: ${nameController.text}');
  print('Saved Email-id: ${emailController.text}');
  print('Saved Phone_number: ${phoneController.text}');
  print('Saved Medical History: ${medicalHistoryController.text}');
  
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.green,
      content: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          SizedBox(width: 8.0),
          Text(
            'Account saved successfully',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    ),
  );
}



  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }
}
