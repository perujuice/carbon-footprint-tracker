import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';


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
        title: const Text('Welcome User!', textAlign: TextAlign.center),
        backgroundColor: Colors.green,
        elevation: 0.0,
      ),
      body: Center(
        child: CalendarCarousel(
          onDayPressed: (DateTime date, List<dynamic> events) {
            // This callback is optional
            print(date);
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
    );
  }
}
