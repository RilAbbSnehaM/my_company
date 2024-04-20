import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Terms & Conditions',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false, // Remove debug banner
      home: TermsAndConditionsPage(),
    );
  }
}

class TermsAndConditionsPage extends StatefulWidget {
  @override
  _TermsAndConditionsPageState createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  late Future<Map<String, dynamic>> _termsAndConditions;

  @override
  void initState() {
    super.initState();
    _termsAndConditions = fetchTermsAndConditions();
  }

  Future<Map<String, dynamic>> fetchTermsAndConditions() async {
    final response = await http.get(
      Uri.parse('https://studylancer.yuktidea.com/api/terms-conditions'),
      headers: {
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
          'Failed to load terms and conditions: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212121), // Background color matching the image
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: _termsAndConditions,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData && snapshot.data != null) {
              // ignore: unused_local_variable
              final data = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.assignment,
                        color: Colors.white,
                        size: 40,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Terms of Service',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Update 16/03/2023',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            } else {
              return Text('No data available.');
            }
          },
        ),
      ),
    );
  }
}
