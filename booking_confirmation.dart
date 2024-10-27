import 'package:flutter/material.dart';
// import 'facility_details.dart';
import 'main.dart';

void main() {
  runApp(const BookingConformation());
}

class BookingConformation extends StatelessWidget {
  const BookingConformation({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove the debug banner
      theme: ThemeData(
        fontFamily: 'Montserrat', // Custom font
        primaryColor: Colors.green, // Theme primary color
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white), // Default text color
        ),
      ),
      home: const BookingConfirmationScreen(time: '2:00 PM'),
    );
  }
}

class BookingConfirmationScreen extends StatelessWidget {
  final String time;

  const BookingConfirmationScreen({
    super.key,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Confirmed'),
        backgroundColor: Colors.green[800],
        elevation: 0, // Flat app bar
      ),
      body: Stack(
        children: [
          // Background image using Stack
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/basketball_bg.jpg'), // Path to your image
                fit: BoxFit.cover, // Cover the entire background
              ),
            ),
          ),
          // Semi-transparent overlay for better readability
          Container(
            color:
                Colors.black.withOpacity(0.6), // Black overlay with 60% opacity
          ),
          // Content over the background
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Confirmation Icon with a drop shadow effect
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.check_circle,
                      color: Colors.green, size: 100),
                ),
                const SizedBox(height: 20),
                // Booking confirmation text
                Text(
                  'Your slot at $time has been successfully booked!',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold, // Bold text
                    color: Colors.white, // White text color
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                // Button with custom styling
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Background color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20), // Rounded button corners
                    ),
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                    elevation: 5, // Button shadow
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BookMyGround(),
                      ),
                    );
                  },
                  child: const Text('Back to Home Screen'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
