import 'package:flutter/material.dart';

class CreateNotice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CreateNoticePage(),
    );
  }
}

class CreateNoticePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Notice'),
        backgroundColor: Colors.grey[400], // AppBar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Placeholder for profile image
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue[100],
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.blue[700],
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Position Name',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              _buildTextField('Company Name', 'Company'),
              _buildTextField('Stipend', 'Money'),
              _buildTextField('Batch', '2023-2025'),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField('Course', 'MCA'),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField('Year', '2nd Year'),
                  ),
                ],
              ),
              _buildTextField('Last date of apply', 'Last Date'),

              // New Fields Added
              _buildTextField('Skills', 'Required Skills'),
              _buildTextField('Criteria', 'Eligibility Criteria'),
              _buildTextField('Location', 'Job Location'),
              _buildTextField('Duration', 'Internship/Job Duration'),
              _buildTextField('Company Details', 'Brief Description'),
              _buildTextField('Responsibility', 'Job Responsibilities'),

              SizedBox(height: 20), // Spacing before the button

              // Create Notice Button
              SizedBox(
                width: double.infinity,
                height: 50, // Set height to make it large
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Red background
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                  ),
                  onPressed: () {
                    // Handle button press logic
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
    );
  }

  Widget _buildTextField(String label, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
