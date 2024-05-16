import 'package:flutter/material.dart';
import 'locations_input.dart';
import 'login_page.dart';
import 'help_page.dart';
import 'info_page.dart';


class ModePage extends StatefulWidget {
  final DateTime? date;
  const ModePage({super.key, this.date});




  @override
  State<ModePage> createState() => _ModePageState();
}


class _ModePageState extends State<ModePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Mode of Transport'),
        backgroundColor: Colors.green,
        elevation: 0.0,
        centerTitle: true,
      ),


      // The code for the main body of the page with the grid of transport options.
      body: Padding(
      padding: const EdgeInsets.only(top: 120.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            _createTransportButton(context, Icons.directions_car, 'Car', 'driving'),
            _createTransportButton(context, Icons.directions_bus, 'Bus', 'bus'),
            _createTransportButton(context, Icons.train, 'Train', 'rail'),
            _createTransportButton(context, Icons.flight, 'Plane', 'flight'),
          ],
        ),
      ),




      // The code for the bottom banner and icons.
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
                MaterialPageRoute(builder: (context) => const InfoPage()),
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
        },
      ),
    );
  }


  // The code for the transport buttons.
  Widget _createTransportButton(BuildContext context, IconData icon, String label, String mode) {
  return TextButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LocationInputPage(mode: mode, date: widget.date)),
      );
    },
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon, size: 50),
        Text(label, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    ),
  );
  }
  }


