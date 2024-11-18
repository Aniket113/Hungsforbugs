import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewNotice extends StatelessWidget {
  final String docid;

  ViewNotice({required this.docid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Company Details'),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot>(
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

          // Extract data from the document
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
                  // Company Name
                  Text(
                    companyName,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),

                  // Position Name
                  Text(
                    'Position: $positionName',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 20),

                  // Company Details
                  Text(
                    'Company Details:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    companyDetails,
                    style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                  ),
                  SizedBox(height: 20),

                  // Responsibilities
                  Text(
                    'Responsibilities:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    responsibility,
                    style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                  ),
                  SizedBox(height: 20),

                  // Required Skills
                  Text(
                    'Required Skills:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    skills,
                    style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                  ),
                  SizedBox(height: 20),

                  // Criteria and Batch
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Criteria: $criteria',
                          style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Batch: $batch',
                          style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Course and Year
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Course: $course',
                          style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Year: $year',
                          style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Location and Duration
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Location: $location',
                          style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Duration: $duration',
                          style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Stipend
                  Row(
                    children: [
                      Icon(Icons.attach_money, color: Colors.green),
                      SizedBox(width: 5),
                      Text(
                        'Stipend: $stipend',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Application Deadline
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.red),
                      SizedBox(width: 5),
                      Text(
                        'Last Date: $lastDate',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Timestamp
                  Row(
                    children: [
                      Icon(Icons.access_time, color: Colors.blue),
                      SizedBox(width: 5),
                      Text(
                        'Posted On: $timestamp',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
