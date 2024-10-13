import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
                Center(
                  child: _buildTextField('Position Name', 'Position', Icons.work, _positionNameController),
                ),
                SizedBox(height: 16),
                _buildTextField('Company Name', 'Company', Icons.business),
                _buildTextField('Stipend', 'Money', Icons.attach_money),
                _buildTextField('Batch', '2023-2025', Icons.date_range),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField('Course', 'MCA', Icons.school),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField('Year', '2nd Year', Icons.calendar_today),
                    ),
                  ],
                ),
                _buildTextField('Last date of apply', 'Last Date', Icons.date_range),
                _buildTextField('Skills', 'Required Skills', Icons.build),
                _buildTextField('Criteria', 'Eligibility Criteria', Icons.check),
                _buildTextField('Location', 'Job Location', Icons.location_on),
                _buildTextField('Duration', 'Internship/Job Duration', Icons.timer),
                _buildTextField('Company Details', 'Brief Description', Icons.info),
                _buildTextField('Responsibility', 'Job Responsibilities', Icons.work),
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle button press logic
                      }
                    },
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

  Widget _buildTextField(String label, String hint, IconData icon, [TextEditingController? controller]) {
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
}
