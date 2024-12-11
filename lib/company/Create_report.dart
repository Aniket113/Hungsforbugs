import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:placement1/company/Create_report.dart';

class CreateReportPage extends StatefulWidget {
  @override
  _CreateReportPageState createState() => _CreateReportPageState();
}

class _CreateReportPageState extends State<CreateReportPage> {
  final _formKey = GlobalKey<FormState>();

  // Form field controllers
  final _organisationController = TextEditingController();
  final _studentController = TextEditingController();
  final _branchController = TextEditingController();
  final _campusController = TextEditingController();
  final _packageController = TextEditingController();
  final _studentNumberController = TextEditingController();
  final _rolePlacedForController = TextEditingController();

  String _placementType = 'Internship';

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    _organisationController.dispose();
    _studentController.dispose();
    _branchController.dispose();
    _campusController.dispose();
    _packageController.dispose();
    _studentNumberController.dispose();
    _rolePlacedForController.dispose();
    super.dispose();
  }

  void _saveForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Save data to Firestore
      try {
        DocumentReference docRef = await FirebaseFirestore.instance
            .collection('companies')
            .add({
          'organisation': _organisationController.text,
          'student': _studentController.text,
          'branch': _branchController.text,
          'campus': _campusController.text,
          'package': _packageController.text,
          'studentNumber': _studentNumberController.text,
          'rolePlacedFor': _rolePlacedForController.text,
          'placementType': _placementType,
        });

        print('Document ID: ${docRef.id}');

        // Clear the form fields after saving
        _organisationController.clear();
        _studentController.clear();
        _branchController.clear();
        _campusController.clear();
        _packageController.clear();
        _studentNumberController.clear();
        _rolePlacedForController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Report saved successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save report: $e')),
        );
      }
    }
  }

  void _viewPlacementReport() {
    // Navigate to the pre-written class for viewing the placement report
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return PlacementReportPage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Create Report', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Create Report',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      SizedBox(height: 20),

                      // Organisation Field
                      TextFormField(
                        controller: _organisationController,
                        decoration: InputDecoration(
                          labelText: 'Organisation',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter an organisation';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      // Student Field
                      TextFormField(
                        controller: _studentController,
                        decoration: InputDecoration(
                          labelText: 'Student',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter a student';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      // Branch Field
                      TextFormField(
                        controller: _branchController,
                        decoration: InputDecoration(
                          labelText: 'Branch',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter a branch';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      // Campus Field
                      TextFormField(
                        controller: _campusController,
                        decoration: InputDecoration(
                          labelText: 'Campus',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter a campus';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      // Package Field
                      TextFormField(
                        controller: _packageController,
                        decoration: InputDecoration(
                          labelText: 'Package',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter a package';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      // Student Number Field
                      TextFormField(
                        controller: _studentNumberController,
                        decoration: InputDecoration(
                          labelText: 'Student Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter a student number';
                          }
                          if (int.tryParse(value!) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      // Role Placed For Field
                      TextFormField(
                        controller: _rolePlacedForController,
                        decoration: InputDecoration(
                          labelText: 'Role Placed For',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter a role';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      // Placement Type Radio Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Placement Type:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  title: const Text('Internship'),
                                  leading: Radio<String>(
                                    value: 'Internship',
                                    groupValue: _placementType,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _placementType = value!;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text('Permanent Placement'),
                                  leading: Radio<String>(
                                    value: 'Permanent Placement',
                                    groupValue: _placementType,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _placementType = value!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),

                      // Save Button
                      SizedBox(
                        width: double.infinity, // full width button
                        child: ElevatedButton(
                          onPressed: _saveForm,
                          child: Text(
                            'SAVE',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent, // background color
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),

                      // View Placement Report Button
                      TextButton(
                        onPressed: _viewPlacementReport,
                        child: Text(
                          'View Placement Report',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PlacementReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Placement Report'),
        backgroundColor: Colors.white,
      ),
      body: PlacementReportTable(),
    );
  }
}

class PlacementReportTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('companies').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        final data = snapshot.requireData;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(label: Text('Organisation')),
              DataColumn(label: Text('Student')),
              DataColumn(label: Text('Branch')),
              DataColumn(label: Text('Campus')),
              DataColumn(label: Text('Package')),
              DataColumn(label: Text('Student Number')),
              DataColumn(label: Text('Role Placed For')),
              DataColumn(label: Text('Placement Type')),
            ],
            rows: data.docs.map((doc) {
              return DataRow(
                cells: <DataCell>[
                  DataCell(Text(doc['organisation'])),
                  DataCell(Text(doc['student'])),
                  DataCell(Text(doc['branch'])),
                  DataCell(Text(doc['campus'])),
                  DataCell(Text(doc['package'])),
                  DataCell(Text(doc['studentNumber'])),
                  DataCell(Text(doc['rolePlacedFor'])),
                  DataCell(Text(doc['placementType'])),
                ],
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
