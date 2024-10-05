import 'package:flutter/material.dart';
import 'package:placement1/student/home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void _login() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Perform login action here (e.g., send request to a server)
      print('Email: $_email');
      print('Password: $_password');
      // Navigate to the home page after successful login
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => JobApplicationHome()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Adjusts to keyboard
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center( // Center the content
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Title
                Text(
                  'Campus Placement App',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 32.0), // Space below the title

                // Email label and text field
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Login ID',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // White background
                    border: Border.all(color: Colors.black), // Black border
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(color: Colors.grey), // Hint text color
                      contentPadding: EdgeInsets.all(12), // Padding inside text field
                    ),
                    style: TextStyle(color: Colors.black), // Text color
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        // return 'Please enter your email'; // Show validation message
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value!;
                    },
                  ),
                ),
                SizedBox(height: 16.0), // Space below the email field

                // Password label and text field
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Password',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // White background
                    border: Border.all(color: Colors.black), // Black border
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(color: Colors.grey), // Hint text color
                      contentPadding: EdgeInsets.all(12), // Padding inside text field
                    ),
                    style: TextStyle(color: Colors.black), // Text color
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        // return 'Please enter your password'; // Show validation message
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value!;
                    },
                  ),
                ),
                SizedBox(height: 32.0), // Space below the password field

                // Sign in button
                ElevatedButton(
                  onPressed: _login,
                  child: Text('Sign In'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey, // Change button color
                    onPrimary: Colors.white, // Text color
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                      side: BorderSide(color: Colors.black), // Black border around button
                    ),
                    elevation: 5, // Shadow for button
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
