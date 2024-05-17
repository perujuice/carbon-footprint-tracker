import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GoalPage extends StatefulWidget {
  const GoalPage({super.key});

  @override
  State<GoalPage> createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  final _goalController = TextEditingController();
  final _dateController = TextEditingController();
  double _totalCO2Output = 0.0;

  @override
  void initState() {
    super.initState();
    _getTotalCO2Output();
  }

  Future<void> _getTotalCO2Output() async {
    const userId = 1; // Replace with actual user ID
    final url = Uri.parse('http://10.0.2.2:8080/users/$userId/co2output');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          _totalCO2Output = double.parse(response.body);
        });
      } else {
        print('Failed to load CO2 output');
      }
    } catch (e) {
      print('Error: $e');
    }
  }



  Future<void> _setUserGoal() async {
    const userId = 1; // Replace with actual user ID
    final url = Uri.parse('http://10.0.2.2:8080/users/$userId/goal');
    final goal = {
      'co2Output': double.parse(_goalController.text),
      'period': _dateController.text,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(goal),
      );

      if (response.statusCode == 200) {
        print('Goal set successfully');
      } else {
        print('Failed to set goal');
      }
    } catch (e) {
      print('Error: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Your Goals!'),
        backgroundColor: Colors.green,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Set your goals here!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _goalController,
                decoration: const InputDecoration(
                  labelText: 'CO2 Goal (in kg)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Date (yyyy-mm-dd)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Your total CO2 output from all trips is $_totalCO2Output kg',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _setUserGoal,
                child: const Text('Set Goal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
