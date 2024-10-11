import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aniket Salvi"),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/profile.png'), // Add your profile image
          ),
        ],
        // Remove leading icon and use a button to open Drawer.
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                // Open the Drawer when the menu icon is clicked
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero, // Removes default padding from the Drawer
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue, // You can customize this color
              ),
              child: Text(
                "Home",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Add Company Details'),
              leading: Icon(Icons.business),
              onTap: () {
                // Handle action for Add Company Details
              },
            ),
            ListTile(
              title: Text('Create Notice'),
              leading: Icon(Icons.note),
              onTap: () {
                // Handle action for Create Notice
              },
            ),
            ListTile(
              title: Text('Create Report'),
              leading: Icon(Icons.report),
              onTap: () {
                // Handle action for Create Report
              },
            ),
            ListTile(
              title: Text('Post Feed'),
              leading: Icon(Icons.feed),
              onTap: () {
                // Handle action for Post Feed
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            JobCard(jobTitle: "Software Developer", companyName: "Accenture"),
            JobCard(jobTitle: "Software Developer", companyName: "LTI Mindtree"),

            SizedBox(height: 20),

            CalendarSection(),

            SizedBox(height: 20),

            ButtonSection(),
          ],
        ),
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final String jobTitle;
  final String companyName;

  JobCard({required this.jobTitle, required this.companyName});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Text(jobTitle),
        subtitle: Text(companyName),
        trailing: ElevatedButton(onPressed: () {}, child: Text('Apply')),
      ),
    );
  }
}

class CalendarSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("June 2024"),
        // Add a calendar widget (TableCalendar package can be used here)
        SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            labelText: "Ends",
            suffixText: "8:00 AM",
          ),
        ),
      ],
    );
  }
}

class ButtonSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(onPressed: () {}, child: Text('Edit Booking')),
        ElevatedButton(onPressed: () {}, child: Text('Post Feed')),
        ElevatedButton(onPressed: () {}, child: Text('Create Event')),
      ],
    );
  }
}
