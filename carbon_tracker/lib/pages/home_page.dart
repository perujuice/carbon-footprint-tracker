import 'package:flutter/material.dart';
import 'login_page.dart';


// This is the main page of the app. It is the first page that the user sees when they open the app.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Departure Location',
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Destination Location',
                  border: InputBorder.none,
                ),
              ), 
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      },
      backgroundColor: Colors.green,
      child: const Icon(Icons.vpn_key),
      )
    );
  } 
}