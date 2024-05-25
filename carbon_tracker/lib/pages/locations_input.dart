import 'package:carbon_tracker/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class LocationInputPage extends StatefulWidget {
  final String mode;
  final DateTime? date;
  final int? userId;


  const LocationInputPage({super.key, required this.mode, this.date, this.userId});


  @override
  State<LocationInputPage> createState() => _LocationInputPageState();
}


class _LocationInputPageState extends State<LocationInputPage> {
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  List<String> stops = ['Departure Location', 'Destination Location'];
  List<String> inputs = ['', ''];
  String distance = '';
  String emission = '';



  
  

  @override
  void initState() {
    super.initState();
    print('User ID: ${widget.userId}, Type: ${widget.userId.runtimeType}');
  }


  Future<void> _setUserTrip() async {
    if (widget.userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must be logged in to save a trip')),
      );
      return;
    }
    
    final url = Uri.parse('http://10.0.2.2:8080/users/${widget.userId}/addTrips');
    final trip = {
      'co2Output': double.parse(emission),
      'distance': double.parse(distance),
      'startLocation': inputs[0],
      'endLocation': inputs[1],
      'mode': widget.mode,
      'date': widget.date != null ? '${widget.date?.year}-${widget.date?.month.toString().padLeft(2,'0')}-${widget.date?.day.toString().padLeft(2,'0')}' : null,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(trip),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Trip saved successfully')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WelcomePage(title: 'Welcome User!', userId: widget.userId!)),
        );
      } else {
        print('Response body: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to save trip')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred while saving the trip')),
      );
    }
  }


  Future<String> getDistance(String start, String end, String mode) async {
  try {
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/getDistance?start=$start&end=$end&mode=$mode'));

    if (response.statusCode == 200) {
      setState(() {
        distance = response.body;
      });
      return response.body;
    } else {
      throw Exception('Failed to get distance. Status code: ${response.statusCode}. Body: ${response.body}');
    }
  } catch (e) {
    print('Error getting distance: $e');
    throw Exception('An error occurred');
  }
}


  Future<void> getEmission(String mode, String distance) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/getEmission?mode=$mode&distance=$distance'));


    if (response.statusCode == 200) {
      setState(() {
        emission = response.body;
      });
    } else {
      throw Exception('Failed to get emission');
    }
  }


  Future<List<String>> getAirports(String input) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/getAirports?input=$input'));


    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<String> airports = data.map<String>((item) => item.toString()).toList();
      return airports;
    } else {
      throw Exception('Failed to get airports');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Locations for ${widget.mode}'),
      ),

      // This is the input form for the locations.
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
                    child: widget.mode == 'flight' ? TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                        autofocus: true,
                        decoration: const InputDecoration(border: OutlineInputBorder()),
                        controller: index == 0 ? _startController : _endController, // Set the controller for this TextField
                      ),
                      suggestionsCallback: (pattern) async {
                        return await getAirports(pattern);
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(suggestion),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        // Split the suggestion on the comma and take the first element
                        String airportCode = suggestion.split(',')[0].trim();

                        // Update the text of the TextField with the airport code
                        if (index == 0) {
                          _startController.text = airportCode;
                          inputs[index] = airportCode;
                        } else {
                          _endController.text = airportCode;
                          inputs[index] = airportCode;
                        }
                      },
                    ) : TextField(
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
            Text('CO2 Emission: $emission kg'),
            ElevatedButton(
              onPressed: () async {
                if (inputs[0].isNotEmpty && inputs[1].isNotEmpty) {
                  String distance = await getDistance(inputs[0], inputs[1], widget.mode);
                  await getEmission(widget.mode, distance);
                  await _setUserTrip();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Submission failed')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        )
      ),
    );
  }
}

