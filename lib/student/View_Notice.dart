import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewNotice extends StatelessWidget {
  final String docid;

  ViewNotice({required this.docid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Company Details', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 2,
      ),
      backgroundColor: Colors.white, // Set light background color
      body: FutureBuilder<DocumentSnapshot>(  // Get company details from Firestore
        future: FirebaseFirestore.instance.collection('notices').doc(docid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('No details found for this company.'));
          }

          final notice = snapshot.data!.data() as Map<String, dynamic>;
          final companyName = notice['companyName'] ?? 'N/A';
          final positionName = notice['positionName'] ?? 'N/A';
          final companyDetails = notice['companyDetails'] ?? 'No details provided.';
          final batch = notice['batch'] ?? 'N/A';
          final course = notice['course'] ?? 'N/A';
          final criteria = notice['criteria'] ?? 'Not specified.';
          final duration = notice['duration'] ?? 'N/A';
          final lastDate = notice['lastDate'] ?? 'N/A';
          final location = notice['location'] ?? 'N/A';
          final responsibility = notice['responsibility'] ?? 'No responsibility details provided.';
          final skills = notice['skills'] ?? 'Not specified.';
          final stipend = notice['stipend'] ?? 'Not disclosed';
          final year = notice['year'] ?? 'N/A';
          final timestamp = notice['timestamp'] != null
              ? (notice['timestamp'] as Timestamp).toDate().toString()
              : 'N/A';

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Company Header
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.blue[50], // Light background color for cards
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            companyName,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Position: $positionName',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Details Section
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.white, // Pure white for clean design
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SectionTitle(title: 'Company Details'),
                          Text(
                            companyDetails,
                            style: TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                          SizedBox(height: 20),
                          SectionTitle(title: 'Responsibilities'),
                          Text(
                            responsibility,
                            style: TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                          SizedBox(height: 20),
                          SectionTitle(title: 'Required Skills'),
                          Text(
                            skills,
                            style: TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Criteria Section
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.blue[50],
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              InfoTile(title: 'Criteria', value: criteria),
                              InfoTile(title: 'Batch', value: batch),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              InfoTile(title: 'Course', value: course),
                              InfoTile(title: 'Year', value: year),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              InfoTile(title: 'Location', value: location),
                              InfoTile(title: 'Duration', value: duration),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Stipend and Deadline Section
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.attach_money, color: Colors.green),
                              SizedBox(width: 5),
                              Text(
                                'Stipend: $stipend',
                                style: TextStyle(fontSize: 16, color: Colors.black87),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.calendar_today, color: Colors.red),
                              SizedBox(width: 5),
                              Text(
                                'Last Date: $lastDate',
                                style: TextStyle(fontSize: 16, color: Colors.black87),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.access_time, color: Colors.blue),
                              SizedBox(width: 5),
                              Text(
                                'Posted On: $timestamp',
                                style: TextStyle(fontSize: 16, color: Colors.black87),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),  // Padding before the button

                  // Apply Button placed below the last card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        // Retrieve the student ID (userId) from local storage (SharedPreferences)
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        String? userId = prefs.getString('docId'); // Retrieve saved userId (docId)

                        if (userId == null) {
                          // Handle case if userId is not available
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('User ID not found')),
                          );
                          return;
                        }

                        // Update Firebase 'applied' collection with the companyId and userId
                        await FirebaseFirestore.instance.collection('applied').doc(userId).set({
                          'companyIds': FieldValue.arrayUnion([docid]), // Add the current companyId to the array
                        }, SetOptions(merge: true)); // Merge to avoid overwriting existing data

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Application sent successfully!')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent,  // Button color
                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),  // Increase vertical and horizontal padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),  // Rounded corners
                        ),
                        elevation: 5,  // Add shadow for a more professional look
                        shadowColor: Colors.black.withOpacity(0.3),  // Soft shadow color
                      ),
                      child: Text(
                        'Apply Now',
                        style: TextStyle(
                          fontSize: 20,  // Increase font size
                          fontWeight: FontWeight.bold,  // Make text bold
                          color: Colors.white,  // Text color
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Reusable Section Title Widget
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.blueAccent,
      ),
    );
  }
}

// Reusable InfoTile Widget for displaying key-value pairs
class InfoTile extends StatelessWidget {
  final String title;
  final String value;

  const InfoTile({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black, // Updated font color to black
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black, // Updated font color to black
            ),
          ),
        ],
      ),
    );
  }
}
