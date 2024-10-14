import 'package:flutter/material.dart';

class ViewNotice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple, // You can change the theme color
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Company Notice"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back), // Icon for the back button
            onPressed: () {
              Navigator.pop(context); // Navigates back to the previous screen
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Company and Role Section with Card
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Colors.deepPurple[50],
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lentra',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'SOC Analyst',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'FINAL INTERNSHIP NOTICE\nFor 2025 Batch',
                          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Company Info Section
                _buildSectionHeader('Company Information'),
                SizedBox(height: 8),
                _buildInfoRow('Company', 'Lentra'),
                _buildInfoRow('Eligible Stream', 'MCS, MCA'),
                _buildInfoRow('Job Location', 'Pune'),
                _buildInfoRow('Job Role', 'SOC Analyst Intern'),
                _buildInfoRow('Stipend', 'INR 20,000/- per month'),
                _buildInfoRow('Duration', '6 months - 1 year'),
                _buildInfoRow('Joining', 'Immediate'),
                SizedBox(height: 20),

                // Responsibilities Section
                _buildSectionHeader('Responsibilities'),
                _buildBulletPoint('Detect & report incidents by monitoring the SIEM console.'),
                _buildBulletPoint('Monitor the SIEM console resources.'),
                _buildBulletPoint('Report the incidents to the concerned team.'),
                _buildBulletPoint('Monitor the health of the SIEM.'),
                // Add more responsibilities similarly...
                SizedBox(height: 20),

                // Skills Required Section
                _buildSectionHeader('Skills Required'),
                _buildBulletPoint('High-level understanding of TCP/IP protocol and OSI Model.'),
                _buildBulletPoint('Hands-on knowledge of Linux-based systems.'),
                _buildBulletPoint('Knowledge of LAN/WAN technologies.'),
                // Add more skills here...
                SizedBox(height: 20),

                // Links Section
                _buildSectionHeader('Application Links'),
                _buildLink('Google Form:', 'https://forms.gle/xTbfiHnHEDEZsbh9'),
                _buildLink('WhatsApp Group:', 'https://chat.whatsapp.com/DZ24m7EiCEKHYQuBRk7Jjf'),
                SizedBox(height: 20),

                // Apply Button
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Apply button function here
                    },
                    icon: Icon(Icons.send),
                    label: Text('Apply'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
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

  // Custom reusable method for section headers
  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.deepPurple,
      ),
    );
  }

  // Custom reusable method for displaying info in rows
  Widget _buildInfoRow(String title, String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$title:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(info),
          ),
        ],
      ),
    );
  }

  // Custom reusable method for bullet points
  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(Icons.circle, size: 8, color: Colors.deepPurple),
          SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  // Custom reusable method for clickable links
  Widget _buildLink(String title, String url) {
    return GestureDetector(
      onTap: () {
        // Add functionality for link tap
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 4),
            Expanded(
              child: Text(
                url,
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
