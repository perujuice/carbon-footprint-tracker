import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Information Page!'),
        backgroundColor: Colors.green,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Center(
              child: Column(
                children: [
                  Text(
                    'This is your annual carbon footprint:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
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
            const SizedBox(height: 30),
            const Row(
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
            const SizedBox(height: 20),
            const Row(
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
            const SizedBox(height: 20),
            const Row(
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
            const SizedBox(height: 30),
            const Center(
              child: Text(
                "You're 23% above the national average.",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
