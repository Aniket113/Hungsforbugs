import 'package:flutter/material.dart';
import 'package:placement1/loginn.dart'; // Your login class
import 'package:placement1/student/student_company.dart';
import 'package:placement1/student/student_profile.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(JobApplicationHome1());
}

class JobApplicationHome1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.teal,
        hintColor: Colors.tealAccent,
      ),
      home: JobApplicationHome(),
    );
  }
}

class JobApplicationHome extends StatefulWidget {
  @override
  _JobApplicationHomeState createState() => _JobApplicationHomeState();
}

class _JobApplicationHomeState extends State<JobApplicationHome> {
  DateTime selectedDate = DateTime.now();
  DateTime focusedDate = DateTime.now();

  // List of job cards data
  List<Map<String, String>> jobCards = [
    {"title": "Software Developer", "company": "Accenture"},
    {"title": "Software Developer", "company": "LTI Mindtree"},
    // Add more jobs if needed
  ];

  String? _userName;

  @override
  void initState() {
    super.initState();
    _getUserData(); // Fetch user data on initialization
  }

  // Function to get the user's name using the stored docId
  Future<void> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDocId = prefs.getString('docId'); // Get the stored docId

    if (userDocId != null) {
      // Fetch data directly from the document using the stored docId
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('students')
          .doc(userDocId)
          .get(); // Fetch the document by docId

      if (userSnapshot.exists && userSnapshot.data() != null) {
        setState(() {
          _userName = userSnapshot['name']; // Access the 'name' field directly
        });
      } else {
        setState(() {
          _userName = 'Unknown User'; // If no data exists, show default
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PopupMenuButton<String>(
              icon: Icon(Icons.menu, color: Colors.white), // Menu icon on the left
              onSelected: (String value) {
                // Handle the selected menu item
                if (value == 'company_available') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CompanyListPage()), // Navigate to Company List page
                  );
                } else if (value == 'logout') {
                  // Navigate to Login Page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()), // Replace LoginPage with your login class
                  );
                }
              },
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    enabled: false, // Disables interaction with the heading
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Home',
                        style: TextStyle(
                          fontSize: 18, // Larger font for the heading
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const PopupMenuDivider(), // Divider after heading
                  const PopupMenuItem<String>(
                    value: 'company_available',
                    child: Row(
                      children: [
                        Icon(Icons.business, color: Colors.white),
                        SizedBox(width: 8),
                        Text('Company Available'),
                      ],
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: Colors.white), // Log Out Icon
                        SizedBox(width: 8),
                        Text('Log Out'), // Log Out Text
                      ],
                    ),
                  ),
                ];
              },
              offset: Offset(0, 40), // Adjust this value as needed for spacing
            ),
            // Display the fetched user name or "Loading..."
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()), // Navigate to ProfilePage
                );
              },
              child: Row(
                children: [
                  Text(
                    _userName ?? "Loading...", // Display user's name or "Loading..."
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: Colors.teal,
                    radius: 20,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              // Job Cards
              ListView.builder(
                shrinkWrap: true, // Important to make the ListView fit inside the Column
                physics: NeverScrollableScrollPhysics(), // Disable the internal scroll of ListView
                itemCount: jobCards.length,
                itemBuilder: (context, index) {
                  return jobCard(
                    jobCards[index]["title"]!,
                    jobCards[index]["company"]!,
                    index,
                  );
                },
              ),
              SizedBox(height: 20),
              // Calendar with selected date
              TableCalendar(
                focusedDay: focusedDate,
                firstDay: DateTime(2023),
                lastDay: DateTime(2030),
                calendarFormat: CalendarFormat.month,
                selectedDayPredicate: (day) {
                  return isSameDay(selectedDate, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    selectedDate = selectedDay;
                    focusedDate = focusedDay;
                  });
                },
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.teal,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.tealAccent,
                    shape: BoxShape.circle,
                  ),
                  defaultTextStyle: TextStyle(color: Colors.white),
                  weekendTextStyle: TextStyle(color: Colors.white),
                  outsideTextStyle: TextStyle(color: Colors.grey),
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(color: Colors.white),
                  leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
                  rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: Colors.white),
                  weekendStyle: TextStyle(color: Colors.white),
                ),
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, date, _) => Center(
                    child: Text(
                      '${date.day}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // "Ends" label and Time input
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Ends",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: '8:00 AM',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.tealAccent),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle "Check My Applied" action
                    },
                    child: Text('Check My Applied'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal, // Background color
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5, // Button shadow
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle "View More Jobs" action
                    },
                    child: Text('View More Jobs'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal, // Background color
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5, // Button shadow
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for Job Card
  Widget jobCard(String jobTitle, String companyName, int index) {
    return Card(
      color: Colors.teal.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.tealAccent),
      ),
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  jobTitle,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  companyName,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.tealAccent,
            ),
          ],
        ),
      ),
    );
  }
}
