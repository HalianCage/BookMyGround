import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
// import 'facility_details.dart';
import 'available_grounds.dart';
import 'package:flutter/material.dart';

void main() async {
  if (kIsWeb) {
    Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCB0aAr5MMH52p0meZV6pCvIUnZ6-A9ri0",
            authDomain: "dtproject-90b5b.firebaseapp.com",
            projectId: "dtproject-90b5b",
            storageBucket: "dtproject-90b5b.appspot.com",
            messagingSenderId: "470103452748",
            appId: "1:470103452748:web:7bb68101bd92a4b90758e9"));
  } else {
    Firebase.initializeApp();
  }
  runApp(const BookMyGround());
}

class BookMyGround extends StatelessWidget {
  const BookMyGround({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookMyGround'),
        backgroundColor: Colors.green[800],
        centerTitle: true,
        elevation: 0,
      ),
      // Wrapping the body with a Stack to set a background image
      body: Stack(
        children: [
          // Background image widget
          Positioned.fill(
            child: Image.asset(
              'assets/football_bg.jpg',
              fit: BoxFit.cover, // Cover the entire background
            ),
          ),
          // Semi-transparent overlay to darken the image
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.4), // Dark overlay
            ),
          ),
          // Foreground content (using a Column for layout)
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for a facility...',
                    prefixIcon: const Icon(Icons.search, color: Colors.green),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true, // Make the text field background filled
                    fillColor:
                        Colors.white.withOpacity(0.8), // Semi-transparent
                  ),
                ),
              ),
              // Add spacing between the search field and the ListView
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  // Add padding to space out the ListView items
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: const [
                    FacilityCard(facilityName: 'Football Turf'),
                    SizedBox(height: 10), // Space between each FacilityCard
                    FacilityCard(facilityName: 'Cricket Grounds'),
                    SizedBox(height: 10),
                    FacilityCard(facilityName: 'Basketball Courts'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FacilityCard extends StatelessWidget {
  final String facilityName;

  const FacilityCard({super.key, required this.facilityName});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: Colors.green[100], // Use light green color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          facilityName,
          style: TextStyle(
            color: Colors.green[800],
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward,
          color: Colors.black87, // Icon color
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AvailableGroundsScreen(
                collectionName: facilityName,
              ),
            ),
          );
        },
      ),
    );
  }
}

//https://github.com/nayan2830/BookMyGround
