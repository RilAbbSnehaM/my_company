import 'package:flutter/material.dart';
import 'package:my_company/logout.dart';
// Import the NextScreen file

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SelectCountryScreen(),
  ));
}

class SelectCountryScreen extends StatefulWidget {
  @override
  _SelectCountryScreenState createState() => _SelectCountryScreenState();
}

class _SelectCountryScreenState extends State<SelectCountryScreen> {
  String? selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212121), // Background color
      appBar: AppBar(
        backgroundColor: Colors.black, // App bar background color
        title: Text('Select Country'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Please select the country where you want to study',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3, // Changed to 3 for three countries in one row
              padding: EdgeInsets.all(16),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                buildCountryCard('Australia'),
                buildCountryCard('Canada'),
                buildCountryCard('Ireland'),
                buildCountryCard('New Zealand'),
                buildCountryCard('USA'),
                buildCountryCard('UK'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ElevatedButton(
              // ignore: unnecessary_null_comparison
              onPressed: selectedCountry != null
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserSettingsPage(
                                selectedCountry!)), // Navigate to NextScreen with selected country
                      );
                    }
                  : null,
              child: Text('Proceed'),
              style: ElevatedButton.styleFrom(
                primary:
                    // ignore: unnecessary_null_comparison
                    selectedCountry != null
                        ? Colors.orange
                        : Colors.grey, // Button background color
                padding: EdgeInsets.symmetric(vertical: 16), // Button padding
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "Can't see the country of your interest? Consult with us",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.orange, // Text color
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCountryCard(String countryName) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCountry = countryName;
        });
      },
      child: Card(
        color: selectedCountry == countryName
            ? Colors.orange
            : Colors.white, // Card background color
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(8.0), // Add padding to the text
            child: Text(
              countryName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Set text color to black
              ),
            ),
          ),
        ),
      ),
    );
  }
}
