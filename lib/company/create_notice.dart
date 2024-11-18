import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(CreateNotice());
}

class CreateNotice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CreateNoticePage(),
    );
  }
}

class CreateNoticePage extends StatefulWidget {
  @override
  _CreateNoticePageState createState() => _CreateNoticePageState();
}

class _CreateNoticePageState extends State<CreateNoticePage> {
  final _formKey = GlobalKey<FormState>();
  final _positionNameController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _stipendController = TextEditingController();
  final _batchController = TextEditingController();
  final _courseController = TextEditingController();
  final _yearController = TextEditingController();
  final _lastDateController = TextEditingController();
  final _skillsController = TextEditingController();
  final _criteriaController = TextEditingController();
  final _locationController = TextEditingController();
  final _durationController = TextEditingController();
  final _companyDetailsController = TextEditingController();
  final _responsibilityController = TextEditingController();

  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _lastDateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _saveNoticeToFirestore() async {
    if (_formKey.currentState!.validate()) {
      try {
        final noticeData = {
          'positionName': _positionNameController.text,
          'companyName': _companyNameController.text,
          'stipend': _stipendController.text,
          'batch': _batchController.text,
          'course': _courseController.text,
          'year': _yearController.text,
          'lastDate': _lastDateController.text,
          'skills': _skillsController.text,
          'criteria': _criteriaController.text,
          'location': _locationController.text,
          'duration': _durationController.text,
          'companyDetails': _companyDetailsController.text,
          'responsibility': _responsibilityController.text,
          'timestamp': FieldValue.serverTimestamp(), // Add timestamp
        };

        // Save to Firestore
        await FirebaseFirestore.instance.collection('notices').add(noticeData);

        // Success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Notice created successfully!')),
        );

        // Clear fields
        _clearFields();
      } catch (e) {
        // Error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create notice: $e')),
        );
      }
    }
  }

  void _clearFields() {
    _positionNameController.clear();
    _companyNameController.clear();
    _stipendController.clear();
    _batchController.clear();
    _courseController.clear();
    _yearController.clear();
    _lastDateController.clear();
    _skillsController.clear();
    _criteriaController.clear();
    _locationController.clear();
    _durationController.clear();
    _companyDetailsController.clear();
    _responsibilityController.clear();
    setState(() {
      _image = null; // Reset image
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Notice'),
        backgroundColor: Colors.deepPurple[400], // AppBar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.deepPurple[100],
                      backgroundImage: _image != null ? FileImage(_image!) : null,
                      child: _image == null
                          ? Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.deepPurple[700],
                      )
                          : null,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                _buildTextField('Position Name', 'Position', Icons.work, _positionNameController),
                _buildTextField('Company Name', 'Company', Icons.business, _companyNameController),
                _buildTextField('Stipend', 'Money', Icons.attach_money, _stipendController),
                _buildTextField('Batch', '2023-2025', Icons.date_range, _batchController),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField('Course', 'MCA', Icons.school, _courseController),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField('Year', '2nd Year', Icons.calendar_today, _yearController),
                    ),
                  ],
                ),
                _buildDateField('Last date of apply', 'Last Date', Icons.date_range),
                _buildTextField('Skills', 'Required Skills', Icons.build, _skillsController),
                _buildTextField('Criteria', 'Eligibility Criteria', Icons.check, _criteriaController),
                _buildTextField('Location', 'Job Location', Icons.location_on, _locationController),
                _buildTextField('Duration', 'Internship/Job Duration', Icons.timer, _durationController),
                _buildTextField('Company Details', 'Brief Description', Icons.info, _companyDetailsController),
                _buildTextField('Responsibility', 'Job Responsibilities', Icons.work, _responsibilityController),
                SizedBox(height: 20), // Spacing before the button
                SizedBox(
                  width: double.infinity,
                  height: 50, // Set height to make it large
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple, // Button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Rounded corners
                      ),
                    ),
                    onPressed: _saveNoticeToFirestore,
                    child: Text(
                      'Create Notice',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, IconData icon, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
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
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDateField(String label, String hint, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _lastDateController,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        readOnly: true,
        onTap: () => _selectDate(context),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select $label';
          }
          return null;
        },
      ),
    );
  }
}
