import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:placement1/company/company_report.dart';

class AddCompanyData extends StatefulWidget {
  @override
  _AddCompanyDataState createState() => _AddCompanyDataState();
}

class _AddCompanyDataState extends State<AddCompanyData> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController hrNameController = TextEditingController();
  final TextEditingController hrMailController = TextEditingController();
  final TextEditingController hrNumberController = TextEditingController();
  final TextEditingController contactDateController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  // Function to save the company data to Firestore
  Future<void> _saveCompanyData() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Create a new document in the "company" collection with a unique ID
        await FirebaseFirestore.instance.collection('company').add({
          'name': nameController.text,
          'hr_name': hrNameController.text,
          'hr_mail': hrMailController.text,
          'hr_number': hrNumberController.text,
          'contact_date': contactDateController.text,
          'location': locationController.text,
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Company data saved successfully')),
        );

        // Clear the form after saving
        _clearForm();
      } catch (e) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save data: $e')),
        );
      }
    }
  }

  // Function to clear the form
  void _clearForm() {
    nameController.clear();
    hrNameController.clear();
    hrMailController.clear();
    hrNumberController.clear();
    contactDateController.clear();
    locationController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Company'),
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the company name';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: hrNameController,
                  decoration: InputDecoration(
                    labelText: 'HR Name',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the HR name';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: hrMailController,
                  decoration: InputDecoration(
                    labelText: 'HR Mail id',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the HR mail id';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: hrNumberController,
                  decoration: InputDecoration(
                    labelText: 'HR Number',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the HR number';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: contactDateController,
                  decoration: InputDecoration(
                    labelText: 'Contact Date',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the contact date';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: locationController,
                  decoration: InputDecoration(
                    labelText: 'Location',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the location';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _saveCompanyData,
                    child: Text('Save'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.blue,
                      textStyle: TextStyle(fontSize: 16),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to view company page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CompanyListPage(),
                        ),
                      );
                    },
                    child: Text('View Company'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.green,
                      textStyle: TextStyle(fontSize: 16),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
