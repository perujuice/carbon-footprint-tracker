import 'package:flutter/material.dart';

class InfoPageBasic extends StatefulWidget {
  const InfoPageBasic({super.key});


  @override
  State<InfoPageBasic> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPageBasic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generic educational information!'),
        backgroundColor: Colors.green,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Here is some information :)',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}