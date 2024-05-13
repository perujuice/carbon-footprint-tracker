import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'goal_page.dart';
import 'help_page.dart';
import 'info_page.dart';
import 'settings_page.dart';


// This is the first page the user sees after logging in. 
// It displays a calendar and allows the user to set goals, 
//view information about the app, and get help.
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key, required this.title});

  final String title;

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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


      body: Center(
        child: CalendarCarousel(
          onDayPressed: (DateTime date, List<dynamic> events) {
          },
          weekendTextStyle: const TextStyle(
            color: Colors.red,
          ),
          thisMonthDayBorderColor: Colors.grey,
          weekFormat: false,
          height: 420.0,
          selectedDateTime: DateTime.now(),
          daysHaveCircularBorder: false,
        ),
      ),


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
        unselectedItemColor: Colors.white.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GoalPage()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InfoPage()),
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
