import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:placement1/loginn.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = ''; // Added variable for name
  String _email = '';
  String _password = '';
  String? _userType;

  // Function to save user data to Firestore in the appropriate collection
  Future<void> _saveUserData() async {
    try {
      // Determine the collection based on userType
      String collectionName = _userType == 'Student' ? 'students' : 'recruiters';

      // Check if email already exists in both collections
      QuerySnapshot studentQuerySnapshot = await FirebaseFirestore.instance
          .collection('students')
          .where('email', isEqualTo: _email)
          .get();

      QuerySnapshot recruiterQuerySnapshot = await FirebaseFirestore.instance
          .collection('recruiters')
          .where('email', isEqualTo: _email)
          .get();

      if (studentQuerySnapshot.docs.isNotEmpty || recruiterQuerySnapshot.docs.isNotEmpty) {
        // Email already exists in either collection
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Oops!',
            message: 'The email is already registered! Click here to login.',
            contentType: ContentType.warning,
          ),
          action: SnackBarAction(
            label: 'Login',
            textColor: Colors.blue,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              ); // Navigate to the login page
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        // Email doesn't exist, proceed with registration
        DocumentReference docRef = await FirebaseFirestore.instance.collection(collectionName).add({
          'name': _name, // Save name to Firestore
          'email': _email,
          'password': _password,
          'userType': _userType,
        });

        // Show "successfully registered" snackbar with clickable login link
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Success!',
            message: 'User registered successfully! Click here to login.',
            contentType: ContentType.success,
          ),
          action: SnackBarAction(
            label: 'Login',
            textColor: Colors.blue,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );  // Navigate to the login page
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print('User data saved successfully in $collectionName collection with ID: ${docRef.id}');
      }
    } catch (error) {
      print('Error saving user data: $error');
    }
  }

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _saveUserData(); // Call function to save data
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Register Yourself',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 32.0),
                // Added Name Field
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Name', style: TextStyle(fontSize: 16)),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter your name',
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.all(12),
                    ),
                    style: TextStyle(color: Colors.black),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _name = value!; // Save name to variable
                    },
                  ),
                ),
                SizedBox(height: 25.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Email', style: TextStyle(fontSize: 16)),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.all(12),
                    ),
                    style: TextStyle(color: Colors.black),
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
                  child: Text('Password', style: TextStyle(fontSize: 16)),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.all(12),
                    ),
                    style: TextStyle(color: Colors.black),
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
                SizedBox(height: 25.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('User Type', style: TextStyle(fontSize: 16)),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonFormField<String>(
                    hint: Text('Select User'),
                    value: _userType,
                    decoration: InputDecoration(border: InputBorder.none),
                    items: ['Student', 'Recruiter'].map((userType) {
                      return DropdownMenuItem(
                        value: userType,
                        child: Text(userType),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _userType = value!;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a user type';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: _signUp,
                  child: Text('Sign Up'),
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
                SizedBox(height: 20), // Add space between button and the text
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    ); // Navigate to the login page
                  },
                  child: Text(
                    'Already registered?',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      // decoration: TextDecoration.overline,
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
}
