import 'package:flutter/material.dart';
import 'package:my_company/Country.dart';
import 'package:my_company/terms.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection
            .ltr, // Change this according to your application's text direction
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String _backgroundImage =
      'https://www.shutterstock.com/shutterstock/photos/2179380689/display_1500/stock-photo-happy-young-asian-saleswoman-looking-at-camera-welcoming-client-smiling-woman-executive-manager-2179380689.jpg'; // initial background image

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Column(children: [
            Container(
              height: height * 0.56,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Image.network(
                "https://media.istockphoto.com/id/182870292/photo/smiling-african-american-student-holding-a-graduation-certificate.jpg?s=612x612&w=0&k=20&c=8H6xiKr82AjyeJ0P0glg64PGp9Khvmdl0wX9euaIpa8=",
              ),
            ),
            Container(
              height: height * 0.44,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(50)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: Colors.white,
                      spreadRadius: 1,
                    ),
                  ],
                  color: Color.fromARGB(255, 37, 37, 37)),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(_backgroundImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Welcome to Study Lancer',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Please select your role to get registered',
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SelectCountryPage()),
                              ); // handle student role selection
                            },
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          const Color.fromARGB(255, 35, 35, 35),
                                      width: 5,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 10,
                                        color:
                                            Color.fromARGB(255, 106, 106, 106),
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: Image.network(
                                    'https://www.shutterstock.com/shutterstock/photos/2179380689/display_1500/stock-photo-happy-young-asian-saleswoman-looking-at-camera-welcoming-client-smiling-woman-executive-manager-2179380689.jpg', // replace with your student image
                                    height: 100,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Student',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 40),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SelectCountryPage()),
                              ); // handle agent role selection
                            },
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          const Color.fromARGB(255, 35, 35, 35),
                                      width: 5,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 10,
                                        color:
                                            Color.fromARGB(255, 147, 145, 145),
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: Image.network(
                                    'https://t3.ftcdn.net/jpg/04/98/01/20/360_F_498012011_8t7qs4duQLJ0ih1h1xVygTKzfwfxO7UE.jpg', // replace with your administrator image
                                    height: 100,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Admin',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TermsAndConditionsPage()),
                          );
                        },
                        child: const Text(
                          'By continuing you agree to our Terms and Conditions',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
