import 'package:flutter/material.dart';
import 'package:placement1/student/View_Notice.dart';

class CompanyListPage extends StatefulWidget {
  @override
  _CompanyListPageState createState() => _CompanyListPageState();
}

class _CompanyListPageState extends State<CompanyListPage> {
  String selectedButton = 'All'; // Default selected button
  bool isEligible = false; // Checkbox for eligible
  bool isNonEligible = false; // Checkbox for non-eligible

  // List of companies
  List<String> companies = ['Accenture', 'LTI', 'Wipro', 'Infosys', 'TCS'];

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

            // Company list in card format
            Expanded(
              child: ListView.builder(
                itemCount: companies.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0), // Padding inside the card
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between elements
                        crossAxisAlignment: CrossAxisAlignment.center, // Center alignment
                        children: [
                          // Column for Designation Name and Company Name
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                            children: [
                              // Designation Name
                              Text(
                                'Full Stack Developer', // Change this to the actual designation
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 4), // Space between designation and company name

                              // Company Name
                              Text(
                                companies[index], // Company name from the list
                                style: TextStyle(
                                  color: Colors.grey[700], // Dark grey color
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),

                          // See more text
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ViewNotice(); // Replace with your pre-written class name
                                  },
                                ),
                              );
                            },
                            child: Text(
                              'See more',
                              style: TextStyle(
                                color: Colors.blue, // Color for the see more link
                                fontSize: 14,
                                // decoration: TextDecoration.underline, // Underline for link effect
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
