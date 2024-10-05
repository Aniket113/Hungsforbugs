import 'package:flutter/material.dart';
import 'package:placement1/student/student_company.dart';
import 'package:placement1/student/student_profile.dart';
import 'package:table_calendar/table_calendar.dart';

class JobApplicationHome1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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

  // Function to remove a job card
  void _removeJobCard(int index) {
    setState(() {
      jobCards.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PopupMenuButton<String>(
              icon: Icon(Icons.menu, color: Colors.black), // Menu icon on the left
              onSelected: (String value) {
                // Handle the selected menu item
                if (value == 'company_available') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CompanyListPage()), // Navigate to Company List page
                  );
                } else if (value == 'my_applied') {
                  // Handle other navigation if necessary
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
                        ),
                      ),
                    ),
                  ),
                  const PopupMenuDivider(), // Divider after heading
                  const PopupMenuItem<String>(
                    value: 'company_available',
                    child: Row(
                      children: [
                        Icon(Icons.business, color: Colors.black),
                        SizedBox(width: 8),
                        Text('Company Available'),
                      ],
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'my_applied',
                    child: Row(
                      children: [
                        Icon(Icons.check, color: Colors.black),
                        SizedBox(width: 8),
                        Text('My Applied'),
                      ],
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'list_items',
                    child: Row(
                      children: [
                        Icon(Icons.list, color: Colors.black),
                        SizedBox(width: 8),
                        Text('List Items'),
                      ],
                    ),
                  ),
                ];
              },
              // Adjust the offset to open below the menu icon
              offset: Offset(0, 40), // Adjust this value as needed for spacing
            ),



            Row(
              children: [
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
                        "Aniket Salvi",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      CircleAvatar(
                        backgroundColor: Colors.blue,
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
            )

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
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
              ),

              SizedBox(height: 20),

              // "Ends" label and Time input
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Ends"),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: '8:00 AM',
                        border: OutlineInputBorder(),
                      ),
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
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle "Search" action
                    },
                    child: Text('Search'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Job card widget with remove icon
  Widget jobCard(String title, String company, int index) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 4),
                Text(
                  company,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    // Handle Apply button press
                  },
                  child: Text('Apply'),
                ),
              ],
            ),
          ),
          // Cross icon in the top-right corner to remove the card
          Positioned(
            right: 0,
            top: 0,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.red),
              onPressed: () {
                _removeJobCard(index); // Call the remove function
              },
            ),
          ),
        ],
      ),
    );
  }
}
