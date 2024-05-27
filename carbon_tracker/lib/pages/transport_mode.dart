import 'package:flutter/material.dart';
import 'locations_input.dart';
import 'login_page.dart';
import 'help_page.dart';
import 'info_page_basic.dart';


class ModePage extends StatefulWidget {
  final DateTime? date;
  final int? userId; // Add this line
  final bool isLoggedIn; // Add this line
  final String? startLocation;
  final String? endLocation;
  const ModePage({super.key, required this.date, this.userId, this.isLoggedIn = false, this.startLocation, this.endLocation}); 





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
    body: Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: <Widget>[
          if (widget.date != null)
            Text(
              'Date: ${widget.date!.day}/${widget.date!.month}/${widget.date!.year}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          if (widget.startLocation != null && widget.endLocation != null)
            Text(
              'Trip: ${widget.startLocation} to ${widget.endLocation}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          const SizedBox(height: 20),
          Expanded(
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
        ],
      ),
    ),
    bottomNavigationBar: BottomNavigationBar(
      backgroundColor: Colors.green,
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: 'Info',
        ),
        if (!widget.isLoggedIn)
          const BottomNavigationBarItem(
            icon: Icon(Icons.vpn_key),
            label: 'Login',
          ),
        const BottomNavigationBarItem(
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
              MaterialPageRoute(builder: (context) => const InfoPageBasic()),
            );
            break;
          case 1:
            if (!widget.isLoggedIn) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            }
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
        MaterialPageRoute(builder: (context) => LocationInputPage(mode: mode, date: widget.date, userId: widget.userId,)),
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


