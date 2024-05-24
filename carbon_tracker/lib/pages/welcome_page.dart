import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'goal_page.dart';
import 'help_page.dart';
import 'info_page.dart';
import 'settings_page.dart';
import 'transport_mode.dart';
import 'package:http/http.dart' as http;



// This is the first page the user sees after logging in.
// It displays a calendar and allows the user to set goals,
//view information about the app, and get help.
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key, required this.title, required this.userId});

  final String title;
  final int userId;

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}


class _WelcomePageState extends State<WelcomePage> {
  late Future<List<Map<String, dynamic>>> tripDates;
  double _progress = 0.0; // This should be the user's progress towards their goal
  double totalCO2Output = 0.0;
  late Future<double>  totalCO2OutputFuture;
  late Future<double> goalFuture;


  @override
  void initState() {
    super.initState();
    tripDates = fetchTripData();
    totalCO2OutputFuture = fetchTotalCO2Output();
    goalFuture = fetchGoal(); 
  }

  Future<List<Map<String, dynamic>>> fetchTripData() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8080/users/${widget.userId}/getTrips'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // You might need to add an Authorization header here if your API requires it
      },
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      List<dynamic> jsonResponse = jsonDecode(response.body);
      print('Trip data: $jsonResponse'); // Print the trip data
      return jsonResponse.map((item) => {
        'date': DateTime.parse(item['date']),
        'startLocation': item['startLocation'],
        'endLocation': item['endLocation'],
      }).toList();
    } else {
      // If the server returns an error response, throw an exception.
      throw Exception('Failed to load trip data');
    }
  }


  Future<double> fetchTotalCO2Output() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/users/${widget.userId}/co2output/past'));

    if (response.statusCode == 200) {
      double totalCO2Output = double.parse(response.body);
      double goal = await goalFuture;
      _progress = totalCO2Output / goal;
      return totalCO2Output;
    } else {
      throw Exception('Failed to fetch total CO2 output');
    }
  }


  Future<double> fetchGoal() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:8080/users/${widget.userId}/goal'));

  if (response.statusCode == 200) {
    Map<String, dynamic> goalData = jsonDecode(response.body);
    if (goalData.containsKey('goal') && goalData['goal'] != null) {
      double goal = double.parse(goalData['goal'].toString());
      return goal;
    } else {
      throw Exception('Goal value is not found or null');
    }
  } else {
    throw Exception('Failed to fetch goal');
  }
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(


      // This is the top green bar with the title and settings icon.
      appBar: AppBar(
        title: const Text('Welcome User!'),
        backgroundColor: Colors.green,
        elevation: 0.0,
        centerTitle: true,
        actions: <Widget> [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const SettingsPage(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    var begin = const Offset(0.0, 1.0);
                    var end = Offset.zero;
                    var curve = Curves.ease;


                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));


                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),


      // This is the calendar that the user can interact with.
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            FutureBuilder<double>(
              future: totalCO2OutputFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    'Total CO2 Output: ${snapshot.data} kg',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
            FutureBuilder<double>(
              future: goalFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    'Your goal: ${snapshot.data} kg',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
            LinearProgressIndicator(
              value: _progress,
              backgroundColor: Colors.grey,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            ),
            Text('${(_progress * 100).toStringAsFixed(1)}%'),
          const SizedBox(height: 20),
          const Text(
            'Select date to log a new trip',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
            const SizedBox(height: 20),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: tripDates,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    flex: 5,
                    child: CalendarCarousel(
                      onDayPressed: (DateTime date, List<dynamic> events) {
                        var trip = snapshot.data!.firstWhere(
                          (trip) => DateTime(trip['date'].year, trip['date'].month, trip['date'].day) == DateTime(date.year, date.month, date.day), 
                          orElse: () => {'date': date, 'startLocation': null, 'endLocation': null},
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ModePage(
                            date: date,
                            userId: widget.userId, 
                            isLoggedIn: true,
                            startLocation: trip['startLocation'],
                            endLocation: trip['endLocation'],
                          )),
                        );
                      },
                      weekendTextStyle: const TextStyle(
                        color: Colors.red,
                      ),
                      thisMonthDayBorderColor: Colors.grey,
                      weekFormat: false,
                      height: 420.0,
                      selectedDateTime: DateTime.now(),
                      daysHaveCircularBorder: false,
                      markedDatesMap: EventList<Event>(
                        events: { for (var item in snapshot.data!) item['date'] : [Event(date: item['date'], title: 'Travel')] },
                      ),
                      markedDateShowIcon: true,
                      markedDateIconMaxShown: 1,
                      markedDateIconBuilder: (event) {
                        return Container(
                          decoration: BoxDecoration(
                            color: event.date.isBefore(DateTime.now()) ? Colors.red : Colors.blue,
                            shape: BoxShape.circle,
                          ),
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),


      // This is the bottom navigation bar that allows the user to navigate to other pages.
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.eco),
            label: 'Set Goals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'Help',
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GoalPage(userId: widget.userId,)),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InfoPage(userId: widget.userId,)),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HelpPage()),
              );
              break;
          }
        }
       
      )
    );
  }
}

