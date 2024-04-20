// ignore_for_file: unused_local_variable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_company/otp.dart';

void main() {
  runApp(const AdminLoginPage());
}

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _phoneNumber = '';
  String _telCode = '+91';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Phone Number:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
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
                      items: const [
                        DropdownMenuItem(
                          value: '+91',
                          child: Text('+91'),
                        ),
                        // Add more country codes here
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter phone number',
                      ),
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
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _login();
                  }
                },
                child: const Text('Verify OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    try {
      final response = await http.post(
        Uri.parse('https://studylancer.yuktidea.com/api/counsellor/login'),
        body: {
          'tel_code': _telCode,
          'phone': _phoneNumber,
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final String token = jsonResponse['token'];
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OTPScreen()),
        );
      } else {
        throw Exception('Failed to log in');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error logging in: $e');
      }
    }
  }
}
