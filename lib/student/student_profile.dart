import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _batchController = TextEditingController();
  final _courseController = TextEditingController();
  final _yearController = TextEditingController();
  final _dobController = TextEditingController(); // Added DOB controller

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // Fetch user data when the page is initialized
  }

  // Method to fetch user data from Firestore
  Future<void> _fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDocId = prefs.getString('docId'); // Get the stored docId

    if (userDocId != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('students')
          .doc(userDocId)
          .get();

      if (userSnapshot.exists) {
        // Fetch and update the email compulsorily
        if (userSnapshot['email'] != null) {
          _emailController.text = userSnapshot['email'];
        } else {
          // Optionally handle the case where email is not available
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Email is not available!')),
          );
        }

        // Fetch existing data for other fields only if available
        _phoneController.text = userSnapshot['phone'] ?? ''; // Default to empty if null
        _batchController.text = userSnapshot['batch'] ?? ''; // Default to empty if null
        _courseController.text = userSnapshot['course'] ?? ''; // Default to empty if null
        _yearController.text = userSnapshot['year'] ?? ''; // Default to empty if null

        if (userSnapshot['dob'] != null) {
          selectedDate = (userSnapshot['dob'] as Timestamp).toDate(); // Fetch existing DOB
          // Set the DOB in the text field
          _dobController.text = '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}';
        }
      }
    }
  }

  // Method to update user data in Firestore
  Future<void> _updateUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDocId = prefs.getString('docId'); // Get the stored docId

    if (userDocId != null) {
      await FirebaseFirestore.instance.collection('students').doc(userDocId).update({
        'phone': _phoneController.text,
        'email': _emailController.text, // Include email in the update
        'batch': _batchController.text,
        'course': _courseController.text,
        'year': _yearController.text,
        'dob': selectedDate != null ? Timestamp.fromDate(selectedDate!) : null, // Save the selected date
      });

      // Optionally, show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => JobApplicationHome1()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ApplicationForm()),
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
                  radius: 60,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              SizedBox(height: 20), // Spacing

              // Phone Number
              _buildTextField(label: 'Phone Number', controller: _phoneController),

              // Email ID
              _buildTextField(label: 'Email ID', controller: _emailController),

              // Batch
              _buildTextField(label: 'Batch', controller: _batchController),

              // Course and Year in the same row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: _buildTextField(label: 'Course', controller: _courseController)),
                  SizedBox(width: 10), // Spacing between the text fields
                  Expanded(child: _buildTextField(label: 'Year', controller: _yearController)),
                ],
              ),

              SizedBox(height: 20), // Spacing

              // DOB TextField
              _buildTextField(label: 'Date of Birth', controller: _dobController, readOnly: true, onTap: () {
                _selectDate(context);
              }),

              SizedBox(height: 20), // Spacing

              // Update Button
              ElevatedButton(
                onPressed: () {
                  _updateUserData(); // Call the update function
                },
                child: Text('Update'), // Renamed to 'Update'
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
  Widget _buildTextField({required String label, required TextEditingController controller, bool readOnly = false, VoidCallback? onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey[700]),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller, // Use the controller for text input
          readOnly: readOnly, // Set readOnly if true
          onTap: onTap, // Call onTap function if provided
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[500],
            hintText: 'Enter $label',
            hintStyle: TextStyle(color: Colors.grey[500]),
            contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
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
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked; // Update selected date
        // Update DOB text field
        _dobController.text = '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}';
      });
    }
  }
}
