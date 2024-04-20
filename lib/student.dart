import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_company/otp.dart';

void main() {
  runApp(
    const MaterialApp(
      home: StudentLoginPage(),
      debugShowCheckedModeBanner: false, // Remove the debug banner
    ),
  );
}

class StudentLoginPage extends StatefulWidget {
  const StudentLoginPage({Key? key}) : super(key: key);

  @override
  _StudentLoginPageState createState() => _StudentLoginPageState();
}

class _StudentLoginPageState extends State<StudentLoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _phoneNumber = '';
  String _telCode = '+91';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212121), // Background color matching the image
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Enter phone number',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Please enter your 10 digit mobile number to receive OTP',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      child: DropdownButton<String>(
                        value: _telCode,
                        onChanged: (value) {
                          setState(() {
                            _telCode = value!;
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            value: '+91',
                            child: Text(
                              '+91',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          // Add more country codes here
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white), // Text color
                        decoration: InputDecoration(
                          hintText: 'Enter phone number',
                          hintStyle:
                              TextStyle(color: Colors.grey), // Hint text color
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a phone number';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _phoneNumber = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _login();
                    }
                  },
                  child: Text('Get OTP'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    try {
      final response = await http.post(
        Uri.parse('https://studylancer.yuktidea.com/api/student/login'),
        body: {
          'tel_code': _telCode,
          'phone': _phoneNumber,
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        // ignore: unused_local_variable
        final String token = jsonResponse['token'];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreen(),
          ),
        );
        // Handle success response as needed
      } else {
        throw Exception('Failed to log in: ${response.statusCode}');
      }
    } catch (e) {
      print('Error logging in: $e');
      // Display a user-friendly error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to log in. Please try again later.'),
          duration: Duration(seconds: 3),
        ),
      );
      // Navigate to the OTP screen even if login fails
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpScreen(),
        ),
      );
    }
  }
}

class OTPScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Center(
        child: Text(
          'Enter OTP here',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
