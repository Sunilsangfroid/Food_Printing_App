import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String selectedPrinter = '';
  String selectedFilamentMaterial = '';
  String selectedFilamentThickness = '';

  List<String> printerTypes = ['Printer A', 'Printer B', 'Printer C'];
  List<String> filamentMaterials = ['PLA', 'ABS', 'PETG', 'TPU'];
  List<String> filamentThicknessOptions = ['1.75mm', '2.85mm', '3.00mm'];

  @override
  void initState() {
    super.initState();
    // Set initial values for dropdowns
    selectedPrinter = printerTypes.first;
    selectedFilamentMaterial = filamentMaterials.first;
    selectedFilamentThickness = filamentThicknessOptions.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Printer Configuration',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButtonFormField(
              value: selectedPrinter,
              decoration:
                  const InputDecoration(labelText: 'Select Printer Type'),
              items: printerTypes.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedPrinter = value.toString();
                });
              },
            ),
            const SizedBox(height: 30),
            const Text(
              'Filament Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            DropdownButtonFormField(
              value: selectedFilamentMaterial,
              decoration:
                  const InputDecoration(labelText: 'Select Filament Material'),
              items: filamentMaterials.map((material) {
                return DropdownMenuItem(
                  value: material,
                  child: Text(material),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedFilamentMaterial = value.toString();
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButtonFormField(
              value: selectedFilamentThickness,
              decoration:
                  const InputDecoration(labelText: 'Select Filament Thickness'),
              items: filamentThicknessOptions.map((thickness) {
                return DropdownMenuItem(
                  value: thickness,
                  child: Text(thickness),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedFilamentThickness = value.toString();
                });
              },
            ),
            const SizedBox(height: 30),
            Center(
              // Centering the button
              child: ElevatedButton(
                onPressed: () {
                  print('Selected Printer: $selectedPrinter');
                  print(
                      'Selected Filament Material: $selectedFilamentMaterial');
                  print(
                      'Selected Filament Thickness: $selectedFilamentThickness');
                },
                // Apply TextStyle with color black to the button text
                child: const Text(
                  'Save Settings',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: SettingsPage(),
  ));
}
