import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(User());
}

// ignore: must_be_immutable
class User extends StatelessWidget {
  var selectedCountry;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Settings',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserSettingsPage(selectedCountry),
      // Remove the debug banner
    );
  }
}

class UserSettingsPage extends StatelessWidget {
  UserSettingsPage(selectedCountry);

  Future<void> _logout(BuildContext context) async {
    final response = await http
        .post(Uri.parse('https://studylancer.yuktidea.com/api/logout'));

    if (response.statusCode == 200) {
      // Navigate to main screen after successful logout
      Navigator.pop(context);
    } else {
      print('Failed to log out');
    }
  }

  Future<void> _deleteUser(BuildContext context) async {
    final response = await http
        .post(Uri.parse('https://studylancer.yuktidea.com/api/delete'));

    if (response.statusCode == 200) {
      // Navigate to main screen after successful user deletion
      Navigator.pop(context);
    } else {
      print('Failed to delete user');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(), // Pushes Welcome text to the top
          Center(
            child: Text(
              'Welcome',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          SizedBox(height: 40),
          Center(
            child: ElevatedButton(
              onPressed: () => _logout(context),
              child: Text('Logout'),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () => _deleteUser(context),
              child: Text('Delete User'),
            ),
          ),
          Spacer(), // Pushes buttons to the bottom
        ],
      ),
    );
  }
}
