import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:placement1/student/View_Notice.dart';

class CompanyListPage extends StatefulWidget {
  @override
  _CompanyListPageState createState() => _CompanyListPageState();
}

class _CompanyListPageState extends State<CompanyListPage> {
  String selectedButton = 'All'; // Default selected button
  bool isEligible = false; // Checkbox for eligible
  bool isNonEligible = false; // Checkbox for non-eligible

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        title: Text('Company List'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search Company',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Toggle buttons for company type
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildToggleButton('Opportunity'),
                SizedBox(width: 10),
                _buildToggleButton('Application'),
                SizedBox(width: 10),
                _buildToggleButton('Offer'),
              ],
            ),
            SizedBox(height: 20),

            // Checkboxes for eligible and non-eligible
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Transform.scale(
                  scale: 0.8, // Adjust the scale value to reduce the size of the checkbox
                  child: Checkbox(
                    value: isEligible,
                    onChanged: (value) {
                      setState(() {
                        isEligible = value!;
                      });
                    },
                  ),
                ),
                Text('Eligible'),
                Transform.scale(
                  scale: 0.8, // Adjust the scale value to reduce the size of the checkbox
                  child: Checkbox(
                    value: isNonEligible,
                    onChanged: (value) {
                      setState(() {
                        isNonEligible = value!;
                      });
                    },
                  ),
                ),
                Text('Non-Eligible'),
              ],
            ),

            SizedBox(height: 20),

            // Dynamic company list from Firestore
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('notices').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final documents = snapshot.data?.docs;

                  if (documents == null || documents.isEmpty) {
                    return Center(child: Text('No notices found.'));
                  }

                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final notice = documents[index];
                      final companyName = notice['companyName'] ?? 'Unknown Company';
                      final positionName = notice['positionName'] ?? 'Unknown Position';
                      final docid = notice.id; // Fetch the document ID

                      return Card(
                        elevation: 4,
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewNotice(docid: docid),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Column for Position Name and Company Name
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Position Name
                                    Text(
                                      positionName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 4), // Space between position and company name

                                    // Company Name
                                    Text(
                                      companyName,
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),

                                // See more text
                                Text(
                                  'See more',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to build toggle buttons with styling
  Widget _buildToggleButton(String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedButton = label;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: selectedButton == label ? Colors.black : Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selectedButton == label ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
