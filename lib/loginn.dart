import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:placement1/company/company_home.dart';
import 'package:placement1/student/home.dart';
import 'package:placement1/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _userType = ''; // User type (Student or Recruiter)

  void _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        // Check in students collection
        QuerySnapshot studentSnapshot = await FirebaseFirestore.instance
            .collection('students')
            .where('email', isEqualTo: _email)
            .where('password', isEqualTo: _password)
            .get();

        // Check in recruiters collection
        QuerySnapshot recruiterSnapshot = await FirebaseFirestore.instance
            .collection('recruiters')
            .where('email', isEqualTo: _email)
            .where('password', isEqualTo: _password)
            .get();

        if (studentSnapshot.docs.isNotEmpty) {
          _userType = 'Student'; // Set user type
          String docId = studentSnapshot.docs[0].id;
          String name = studentSnapshot.docs[0]['name']; // Retrieve name
          await _saveDocIdToLocalStorage(docId); // Save docId to local storage
          print('Logged in as Student, Name: $name, Doc ID: $docId'); // Print Name and Doc ID

          _showSuccessAlert('Login successful! Welcome $name!');
          Future.delayed(Duration(seconds: 2), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => JobApplicationHome1()),
            );
          });
        } else if (recruiterSnapshot.docs.isNotEmpty) {
          _userType = 'Recruiter'; // Set user type
          String docId = recruiterSnapshot.docs[0].id;
          String name = recruiterSnapshot.docs[0]['name']; // Retrieve name
          await _saveDocIdToLocalStorage(docId); // Save docId to local storage
          print('Logged in as Recruiter, Name: $name, Doc ID: $docId'); // Print Name and Doc ID

          _showSuccessAlert('Login successful! Welcome $name!');
          Future.delayed(Duration(seconds: 2), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashboardScreen()),
            );
          });
        } else {
          _showErrorSnackbar('Invalid credentials, check email or password');
        }
      } catch (e) {
        print('Error during login: $e');
        _showErrorSnackbar('An error occurred, please try again');
      }
    }
  }

  Future<void> _saveDocIdToLocalStorage(String docId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('docId', docId);
      print('Doc ID saved to local storage: $docId');
    } catch (e) {
      print('Error saving Doc ID: $e');
    }
  }

  Future<String?> _retrieveDocIdFromLocalStorage() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('docId'); // Retrieve docId from local storage
    } catch (e) {
      print('Error retrieving Doc ID: $e');
      return null;
    }
  }

  void _showSuccessAlert(String message) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      text: message,
      autoCloseDuration: const Duration(seconds: 2),
    );
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AwesomeSnackbarContent(
          title: 'Error',
          message: message,
          contentType: ContentType.failure,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade800, Colors.black87],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Campus Placement App',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 32.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Login ID',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      border: Border.all(color: Colors.white70),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(color: Colors.white70),
                        contentPadding: EdgeInsets.all(12),
                      ),
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value!;
                      },
                    ),
                  ),
                  SizedBox(height: 25.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Password',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      border: Border.all(color: Colors.white70),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(color: Colors.white70),
                        contentPadding: EdgeInsets.all(12),
                      ),
                      style: TextStyle(color: Colors.white),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value!;
                      },
                    ),
                  ),
                  SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: _login,
                    child: Text('Sign In'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.black),
                      ),
                      elevation: 5,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
