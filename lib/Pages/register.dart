import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:itrm_screen/globals.dart';
import 'package:mime/mime.dart';


Future<void> initializeFirebase() async {
  await Firebase.initializeApp();
}
class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController medicalHistoryController = TextEditingController();
  String selectedGender = 'Male';
  String selectedCountryCode = '+91';
  int profileCompletion = 0;
  // File? selectedImage;

  @override
  Widget build(BuildContext context) {
    selectedImage=null;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Registration Form'),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Complete Your Profile',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            // Profile Image Field
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
                    : Icon(
                        Icons.person,
                        size: 60,
                      ),
              ),
            ),
            SizedBox(height: 20.0),
            buildContainerWithLabel(
              'Name', 
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            buildContainerWithLabel(
              'Email', 
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
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
                  Expanded(child: buildInputField(phoneController, inputType: TextInputType.phone)),
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
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Select Date',
                    ),
                  ),
                ),
              ),
            ),
            buildContainerWithDropdown(
                'Gender', ['Male', 'Female', 'Other'], selectedGender,
                (value) {
              setState(() {
                selectedGender = value;
              });
            }),
            buildContainerWithLabel(
              'Height (cm)', 
              buildInputField(heightController, inputType: TextInputType.number),
            ),
            buildContainerWithLabel(
              'Weight (kg)', 
              buildInputField(weightController, inputType: TextInputType.number),
            ),
            buildContainerWithLabel(
              'Medical History*', 
              buildMedicalHistoryField(medicalHistoryController),
            ),
            SizedBox(height: 20.0),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  _register();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
                child: Text('Register'),
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
  Widget buildInputField(TextEditingController controller, {required TextInputType inputType}) {
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
        decoration: InputDecoration(
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
        decoration: InputDecoration(
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

  void _pickImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
        if (selectedImage!=null) {
          selectedImage!.copy('$docPath/pfp.jpg');
        }
        print("selectedImage = ${pickedFile.path}");
      });
    }
  }

  void _pickDateOfBirth() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Enter Date of Birth'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: dobController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                hintText: 'DD/MM/YYYY',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
              });
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}



  void _register() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        dobController.text.isEmpty ||
        heightController.text.isEmpty ||
        weightController.text.isEmpty ||
        phoneController.text.isEmpty ||
        medicalHistoryController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please fill all sections',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
    } else {
      try {
        String? imageUrl;
        if (selectedImage != null) {
          final storageRef = FirebaseStorage.instance.ref().child('user_images/${FirebaseAuth.instance.currentUser!.uid}');
          final uploadTask = storageRef.putFile(selectedImage!,SettableMetadata(contentType: lookupMimeType(selectedImage!.path)));
          final snapshot = await uploadTask.whenComplete(() => print('uploaded pfp'));
          imageUrl = await snapshot.ref.getDownloadURL();
        }
        userProfile=Profile(
          name: nameController.text,
          email: FirebaseAuth.instance.currentUser!.email,
          dob: dobController.text,
          height: double.parse(heightController.text),
          weight: double.parse(weightController.text),
          medHistory: medicalHistoryController.text,
          gender: selectedGender,
          phoneNo: phoneController.text,
          );
        addUser(userProfile!, imageUrl!);
        localDb.collection('data').doc('user').set(userProfile!.toFirestore("image path here"));

        // await FirebaseFirestore.instance.collection('users').add({
        //   'name': nameController.text,
        //   'email': emailController.text,
        //   'dob': dobController.text,
        //   'height': double.parse(heightController.text),
        //   'weight': double.parse(weightController.text),
        //   'medicalHistory': medicalHistoryController.text,
        //   'imageUrl': imageUrl,
        // });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Registration successful!',
              style: TextStyle(color: Colors.green),
            ),
          ),
        );

        Navigator.pushReplacementNamed(context, '/home');
      } catch (error) {
        print('Error registering user: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'An error occurred. Please try again later.',
              style: TextStyle(color: Colors.red),
            ),
          ),
        );
      }
    }
  }


}
