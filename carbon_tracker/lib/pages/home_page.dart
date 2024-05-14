import 'package:flutter/material.dart';
import 'login_page.dart';
import 'goal_page.dart';
import 'help_page.dart';
import 'package:http/http.dart' as http;


// This is the main page of the app. It is the first page that the user sees when they open the app.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> stops = ['Departure Location', 'Destination Location'];
  List<String> inputs = ['', ''];
  String distance = '';

  // This function gets the distance between two locations.
  Future<void> getDistance(String start, String end) async {
    // The IP address, localhost wont work on the emulator since it is running on a different machine.
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/getDistance?start=$start&end=$end'));

    if (response.statusCode == 200) {
      setState(() {
        distance = response.body;
      });
    } else {
      throw Exception('Failed to get distance');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
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
                      onChanged: (value) {
                        inputs[index] = value;
                      },
                      decoration: InputDecoration(
                        hintText: stops[index],
                        border: InputBorder.none,
                      ),
                    ),
                  );
                },
              ),
            ),
            Text('Distance: $distance km'),
            ElevatedButton(
              onPressed: () {
                getDistance(inputs[0], inputs[1]);
              },
              child: Text('Submit'),
            ),
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      stops.insert(stops.length - 1, 'Stop ${stops.length - 1}');
                      inputs.add('');
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