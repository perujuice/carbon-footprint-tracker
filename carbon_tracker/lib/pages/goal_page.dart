import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class GoalPage extends StatefulWidget {
  final int userId;
  const GoalPage({super.key, required this.userId});

  @override
  State<GoalPage> createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  final _goalController = TextEditingController();
  final _dateController = TextEditingController();
  late double _totalCO2Output = 0.0;

  @override
  void initState() {
    super.initState();
    fetchTotalCO2Output();
  }


  Future<void> fetchTotalCO2Output() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/users/${widget.userId}/co2output/past'));

    if (response.statusCode == 200) {
      setState(() {
        _totalCO2Output = double.parse(response.body);
      });
    } else {
      throw Exception('Failed to fetch total CO2 output');
    }
  }


  Future<void> _setUserGoal() async {
    const userId = 1; // Replace with actual user ID
    final url = Uri.parse('http://10.0.2.2:8080/users/$userId/goal');
    final goal = {
      'co2Output': double.parse(_goalController.text),
      'targetDate': _dateController.text,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(goal),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Goal set successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to set goal')),
        );
      }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An error occurred while setting the goal')),
        );
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'This is your total carbon footprint this year:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 10),
                          // This is to be replaced by the actual carbon footprint
                          Text(
                            //'$totalCO2Output',
                            '23.98',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Tons CO2e',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            'You',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: LinearProgressIndicator(
                            value: 1.0,
                            backgroundColor: Colors.grey,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '23.98 Tons',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Avg Sweden',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: LinearProgressIndicator(
                            value: 19.49 / 23.98,
                            backgroundColor: Colors.grey,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '19.49 Tons',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Avg World',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: LinearProgressIndicator(
                            value: 4.51 / 23.98,
                            backgroundColor: Colors.grey,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '4.51 Tons',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: Text(
                        "You're 23% above the national average.",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              const Text(
                "Define your CO2 emission limit and strive to stay below it until your specified target date.",
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
              TextButton(
                onPressed: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                  }
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _dateController,
                    decoration: const InputDecoration(
                      labelText: 'Date (yyyy-mm-dd)',
                      border: OutlineInputBorder(),
                    ),
                  ),
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
