import 'package:flutter/material.dart';
import 'package:placement1/student/home.dart';
import 'package:placement1/student/student_application.dart';

class ProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => JobApplicationHome1()), // Navigate to ProfilePage
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ApplicationForm()), // Navigate to ProfilePage
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Blue avatar logo for browsing photos
              GestureDetector(
                onTap: () {
                  // Handle browse photo action
                },
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 60, // Adjust size as needed
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              SizedBox(height: 20), // Spacing

              // Phone Number
              _buildTextField(label: 'Phone Number'),

              // Email ID
              _buildTextField(label: 'Email ID'),

              // Batch
              _buildTextField(label: 'Batch'),

              // Course and Year in the same row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: _buildTextField(label: 'Course')),
                  SizedBox(width: 10), // Spacing between the text fields
                  Expanded(child: _buildTextField(label: 'Year')),
                ],
              ),

              SizedBox(height: 20), // Spacing

              // DOB
              Row(
                mainAxisAlignment: MainAxisAlignment.start, // Ensures alignment on the left
                crossAxisAlignment: CrossAxisAlignment.center, // Aligns text and button in the same line
                children: [
                  Text(
                    'Date of Birth',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 20), // Space between label and button
                  ElevatedButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    child: Text(
                      selectedDate == null
                          ? 'Select Date'
                          : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20), // Spacing

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  // Handle submit action
                },
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to build labeled text fields
  Widget _buildTextField({required String label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey[700]),
        ),
        SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[100],
            hintText: 'Enter $label',
            hintStyle: TextStyle(color: Colors.grey[500]),
            contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none, // No border line
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: Colors.blue, width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: Colors.grey[300]!, width: 1.0),
            ),
          ),
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 20), // Spacing
      ],
    );
  }

  // Method to select date using a date picker
  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked; // Update selected date
      });
  }
}
