import 'package:flutter/material.dart';
import 'package:placement1/company/Create_report.dart';
import 'package:placement1/company/add_company_data.dart'; // Assuming AddCompanyData class exists here
import 'package:table_calendar/table_calendar.dart';
import 'package:placement1/company/coordinator_profile.dart';
import 'package:placement1/company/create_notice.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: Colors.black87, // AppBar background color
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                // Show dropdown menu
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(0, 50, 0, 0),
                  items: [
                    PopupMenuItem<String>(
                      value: 'add_company',
                      child: Row(
                        children: [
                          Icon(Icons.business, color: Colors.black),
                          SizedBox(width: 8),
                          Text('Add Company Details'),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'create_notice',
                      child: Row(
                        children: [
                          Icon(Icons.note, color: Colors.black),
                          SizedBox(width: 8),
                          Text('Create Notice'),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'create_report',
                      child: Row(
                        children: [
                          Icon(Icons.report, color: Colors.black),
                          SizedBox(width: 8),
                          Text('Create Report'),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'post_feed',
                      child: Row(
                        children: [
                          Icon(Icons.feed, color: Colors.black),
                          SizedBox(width: 8),
                          Text('Post Feed'),
                        ],
                      ),
                    ),
                  ],
                ).then((value) {
                  // Handle navigation based on selected value
                  if (value == 'add_company') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddCompanyData(), // Navigate to Add Company Details page
                      ),
                    );
                  } else if (value == 'create_notice') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateNotice(), // Navigate to Create Notice page
                      ),
                    );
                  } else if (value == 'create_report') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateReportPage(), // Navigate to Create Report page
                      ),
                    );
                  } else if (value == 'post_feed') {
                    // Implement Post Feed functionality here
                  }
                });
              },
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Center(
              child: Text(
                "Aniket Salvi",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
          IconButton(
            icon: CircleAvatar(
              backgroundImage: AssetImage('assets/profile.png'),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()), // Navigate to Profile page
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.grey[850]!], // Background gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              // Feed section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Feed",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Feed title color
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1), // Card background
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          JobCard(
                            jobTitle: "Software Developer",
                            companyName: "Accenture",
                          ),
                          JobCard(
                            jobTitle: "Software Developer",
                            companyName: "LTI Mindtree",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Calendar section
              CalendarSection(),
              SizedBox(height: 20),
              // Buttons section
              ButtonSection(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue, // Floating action button color
        onPressed: () {
          // Handle the floating action button press
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black87, // Bottom bar color
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {
                // Navigate to home
              },
            ),
            IconButton(
              icon: Icon(Icons.notifications, color: Colors.white),
              onPressed: () {
                // Navigate to notifications
              },
            ),
            IconButton(
              icon: Icon(Icons.settings, color: Colors.white),
              onPressed: () {
                // Navigate to settings
              },
            ),
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
      color: Colors.purple.withOpacity(0.2), // Job card color
      child: ListTile(
        title: Text(
          jobTitle,
          style: TextStyle(color: Colors.white), // Job title color
        ),
        subtitle: Text(
          companyName,
          style: TextStyle(color: Colors.grey[300]), // Company name color
        ),
        trailing: ElevatedButton(
          onPressed: () {},
          child: Text('Apply'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // Button color
          ),
        ),
      ),
    );
  }
}

class CalendarSection extends StatefulWidget {
  @override
  _CalendarSectionState createState() => _CalendarSectionState();
}

class _CalendarSectionState extends State<CalendarSection> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "June 2024",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(height: 10),
        TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          calendarFormat: CalendarFormat.month,
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: TextStyle(color: Colors.white), // Calendar title color
            leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white), // Left arrow color
            rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white), // Right arrow color
          ),
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Colors.blue, // Today's date color
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Colors.blueAccent, // Selected date color
              shape: BoxShape.circle,
            ),
            defaultTextStyle: TextStyle(color: Colors.white), // Default text color
            weekendTextStyle: TextStyle(color: Colors.red), // Weekend text color
            outsideTextStyle: TextStyle(color: Colors.grey), // Outside text color
          ),
        ),
      ],
    );
  }
}

class ButtonSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Text('Edit Booking'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Post Feed'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Cancel Booking'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          ),
        ],
      ),
    );
  }
}
