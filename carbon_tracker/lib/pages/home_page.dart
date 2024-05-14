import 'package:flutter/material.dart';
import 'login_page.dart';
import 'goal_page.dart';
import 'help_page.dart';


// This is the main page of the app. It is the first page that the user sees when they open the app.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> stops = ['Departure Location', 'Destination Location'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // this signifies the top bar of the app
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu), 
            onSelected: (String result) {
              // Handle your action
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Action1',
                child: Text('Action 1'),
              ),
              const PopupMenuItem<String>(
                value: 'Action2',
                child: Text('Action 2'),
              ),
            ],
          ),
        ],
      ),

      // This is for the input boxes in the center of the home screen.
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: stops.length,
                padding: EdgeInsets.only(
                  top: stops.length <= 2 ? MediaQuery.of(context).size.height * 0.25 : 10.0,
                  bottom: 10.0,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: stops[index],
                        border: InputBorder.none,
                      ),
                    ),
                  );
                },
              ),
            ),
            Column(
        children: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                stops.insert(stops.length - 1, 'Stop ${stops.length - 1}');
              });
            },
          ),
          const Text('Add Stop'),
        ],
            ),
          ],
        ),
      ),


      // This is the bottom navigation bar that allows the user to navigate to other pages.
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.vpn_key),
            label: 'Login',
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
                MaterialPageRoute(builder: (context) => const GoalPage()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
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