import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_company/select.dart';

// Import the NextScreen file

void main() {
  runApp(OtpScreen());
}

class OtpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OTP Verification',
      theme: ThemeData(
        primaryColor: Color(0xFF212121), // Background color matching the image
        hintColor: Colors.orange, // Accent color for buttons
        scaffoldBackgroundColor: Color(0xFF212121), // Scaffold background color
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.white), // Text color
        ),
      ),
      // Remove the debug banner
      home: Scaffold(
        appBar: AppBar(
          title: Text('Verify Number'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: OTPScreen(),
      ),
    );
  }
}

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpController = TextEditingController();
  String verificationMessage = '';

  Future<void> verifyOTP() async {
    final String verifyOTPUrl =
        'https://studylancer.yuktidea.com/api/verify-otp';

    final response = await http.post(
      Uri.parse(verifyOTPUrl),
      body: {
        'otp': otpController.text,
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        verificationMessage = 'OTP Verified Successfully!';
      });
    } else {
      setState(() {
        verificationMessage = 'Failed to verify OTP. Please try again.';
      });
    }

    // Navigate to SelectCountryScreen regardless of response status code
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectCountryScreen()),
    );
  }

  Future<void> resendOTP() async {
    final String resendOTPUrl =
        'https://studylancer.yuktidea.com/api/resend-otp';

    final response = await http.post(Uri.parse(resendOTPUrl));

    if (response.statusCode == 200) {
      setState(() {
        verificationMessage = 'OTP Resent Successfully!';
      });
    } else {
      setState(() {
        verificationMessage = 'Failed to resend OTP. Please try again.';
      });
    }

    // Navigate to SelectCountryScreen regardless of response status code
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectCountryScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Verify Number',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            'Please enter the OTP received to verify your number',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.orange,
            ),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 0; i < 6; i++)
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color for OTP digits
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      counterText: '',
                    ),
                    maxLength: 1,
                  ),
                ),
            ],
          ),
          SizedBox(height: 20.0),
          TextButton(
            onPressed: resendOTP,
            child: Text(
              'Resend OTP?',
              style: TextStyle(
                fontSize: 18,
                color: Colors.orange, // Change text color to orange
              ),
            ),
          ),
          SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: verifyOTP,
            child: Text(
              'Verify',
              style: TextStyle(fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.orange, // Background color
              padding: EdgeInsets.symmetric(vertical: 15.0), // Button padding
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(10.0), // Button border radius
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            verificationMessage,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
