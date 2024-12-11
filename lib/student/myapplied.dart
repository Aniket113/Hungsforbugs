import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApplied extends StatefulWidget {
  @override
  _MyAppliedState createState() => _MyAppliedState();
}

class _MyAppliedState extends State<MyApplied> {
  List<Map<String, dynamic>> appliedCompanies = [];

  @override
  void initState() {
    super.initState();
    _fetchAppliedCompanies();
  }

  // Fetch user ID from SharedPreferences and applied companies
  Future<void> _fetchAppliedCompanies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('docId');  // Assuming 'docId' is the key where user ID is saved

    if (userId == null) {
      // Handle case where user ID is not found
      print("User ID not found");
      return;
    }

    // Query the 'applied' collection for the user document
    DocumentSnapshot appliedSnapshot = await FirebaseFirestore.instance
        .collection('applied')
        .doc(userId)
        .get();

    if (appliedSnapshot.exists) {
      // Get the company IDs from the user's applied document
      List<dynamic> companyIds = appliedSnapshot['companyIds'] ?? [];

      // Fetch the company details from the 'notices' collection
      for (String companyId in companyIds) {
        DocumentSnapshot noticeSnapshot = await FirebaseFirestore.instance
            .collection('notices')
            .doc(companyId)
            .get();

        if (noticeSnapshot.exists) {
          Map<String, dynamic> companyDetails = noticeSnapshot.data() as Map<String, dynamic>;
          appliedCompanies.add({
            'companyName': companyDetails['companyName'],
            'duration': companyDetails['duration'],
            'skill': companyDetails['skills'],
            'position': companyDetails['positionName'],
            'salary': companyDetails['stipend'],
          });
        }
      }

      setState(() {
        // Trigger a rebuild to display the data
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Company List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: appliedCompanies.isEmpty
            ? Center(child: CircularProgressIndicator()) // Show loading spinner while fetching data
            : SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'Company Name',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  'Duration',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  'Skill',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  'Position',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  'Salary',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ],
            rows: appliedCompanies.map<DataRow>((company) {
              return DataRow(
                cells: <DataCell>[
                  DataCell(Text(company['companyName'] ?? 'N/A')),
                  DataCell(Text(company['duration'] ?? 'N/A')),
                  DataCell(Text(company['skill'] ?? 'N/A')),
                  DataCell(Text(company['position'] ?? 'N/A')),
                  DataCell(Text(company['salary'] ?? 'N/A')),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
