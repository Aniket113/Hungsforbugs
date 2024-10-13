import 'package:flutter/material.dart';
import 'package:placement1/company/add_company_data.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:placement1/company/coordinator_profile.dart';
import 'package:placement1/company/create_notice.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
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
                style: TextStyle(fontSize: 18),
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
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
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
                // Replace `YourPrewrittenClassName` with the name of your pre-written class
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddCompanyData()),
                );
              },
            ),
            ListTile(
              title: Text('Create Notice'),
              leading: Icon(Icons.note),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateNoticePage()),
                );
              },
            ),
            ListTile(
              title: Text('Create Report'),
              leading: Icon(Icons.report),
              onTap: () {},
            ),
            ListTile(
              title: Text('Post Feed'),
              leading: Icon(Icons.feed),
              onTap: () {
                // Show the pop-up with text input when "Post Feed" is clicked
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true, // Allows the modal to move up with the keyboard
                  builder: (context) => PostFeedPopup(),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            // Feed section with frame
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Feed",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
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
            // Buttons side by side with the calendar
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
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
          ElevatedButton(onPressed: () {}, child: Text('Edit Booking')),
          ElevatedButton(onPressed: () {}, child: Text('Post Feed')),
          ElevatedButton(onPressed: () {}, child: Text('Create Event')),
        ],
      ),
    );
  }
}

class PostFeedPopup extends StatefulWidget {
  @override
  _PostFeedPopupState createState() => _PostFeedPopupState();
}

class _PostFeedPopupState extends State<PostFeedPopup> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets, // Moves the widget up above the keyboard
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Minimizes the modal size to its content
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: "Write your post here...",
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Logic for posting the feed
                    print("Posted: ${_textController.text}");
                    Navigator.pop(context); // Close the popup after posting
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
