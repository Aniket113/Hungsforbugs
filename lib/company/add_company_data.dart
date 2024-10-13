import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
//import 'dart:io';

class AddCompanyData extends StatefulWidget {
  @override
  _AddCompanyDataState createState() => _AddCompanyDataState();
}

class _AddCompanyDataState extends State<AddCompanyData> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Company'),
        backgroundColor: Colors.deepPurple[400], // AppBar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                _buildTextField('Name', 'Company Name', Icons.business),
                _buildTextField('HR Name', 'HR Name', Icons.person),
                _buildTextField('HR Mail id', 'HR Mail id', Icons.email),
                _buildTextField('HR Number', 'HR Number', Icons.phone),
                _buildTextField('Contact Date', 'Contact Date', Icons.date_range),
                _buildTextField('Location', 'Location', Icons.location_on),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Process data
                        }
                      },
                      child: Text('Save'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        // Navigate to view company page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CompanyListPage(), // Replace with your actual class
                          ),
                        );
                      },
                      child: Text('View Company'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the $label';
          }
          return null;
        },
      ),
    );
  }
}

// Dummy class to represent CompanyListPage
class CompanyListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Company List'),
      ),
      body: Center(
        child: Text('List of companies will be shown here.'),
      ),
    );
  }
}
