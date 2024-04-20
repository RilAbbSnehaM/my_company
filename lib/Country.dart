import 'package:flutter/material.dart';
import 'package:my_company/student.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Select Country',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor:
            Color(0xFF212121), // Background color matching the image
      ),
      home: SelectCountryPage(),
    );
  }
}

class SelectCountryPage extends StatefulWidget {
  @override
  _SelectCountryPageState createState() => _SelectCountryPageState();
}

class _SelectCountryPageState extends State<SelectCountryPage> {
  final List<Map<String, dynamic>> countries = [
    {'name': 'Armenia', 'dial_code': '+21'},
    {'name': 'Australia', 'dial_code': '+23'},
    {'name': 'Austria', 'dial_code': '+24'},
    {'name': 'Bahamas', 'dial_code': '+76'},
    {'name': 'Bangladesh', 'dial_code': '+34'},
    {'name': 'Belgium', 'dial_code': '+10'},
    {'name': 'Benin', 'dial_code': '+63'},
    {'name': 'Cameroon', 'dial_code': '+21'},
    {'name': 'Canada', 'dial_code': '+21'},
    {'name': 'Cape Verde', 'dial_code': '+21'},
    {'name': 'Chad', 'dial_code': '+21'},
    {'name': 'Chile', 'dial_code': '+21'},
    {'name': 'China', 'dial_code': '+21'},
    {'name': 'Colombia', 'dial_code': '+21'},
    // Add more countries as needed
  ];

  List<Map<String, dynamic>> filteredCountries = [];

  @override
  void initState() {
    super.initState();
    filteredCountries = countries;
  }

  void filterCountries(String query) {
    setState(() {
      if (query.isNotEmpty) {
        filteredCountries = countries
            .where((country) =>
                country['name'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        filteredCountries = countries;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Select your country',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: filterCountries,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor:
                    Colors.grey[800], // Adjust the color to match the image
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCountries.length,
              itemBuilder: (context, index) {
                final country = filteredCountries[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(
                        'assets/images/${country['name'].toLowerCase()}America.png'), // Add appropriate image assets
                  ),
                  title: Text(country['name']),
                  subtitle: Text(country['dial_code']),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentLoginPage()));
                    // Handle onTap
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
