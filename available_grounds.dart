import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'facility_details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AvailableGroundsScreen(
          collectionName: 'Cricket Grounds'), // Pass the collection name here
    );
  }
}

class AvailableGroundsScreen extends StatelessWidget {
  final String collectionName;

  const AvailableGroundsScreen({super.key, required this.collectionName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$collectionName'),
        backgroundColor: Colors.green[800],
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/cricket_bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Main content
          Container(
            color: Colors.black.withOpacity(0.6),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection(collectionName)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return const Center(child: CircularProgressIndicator());

                final grounds = snapshot.data!.docs.map((doc) {
                  return Ground(
                    name: doc.id,
                    location: doc['Location'],
                    isAvailable: doc['Availability'],
                  );
                }).toList();

                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: grounds.length,
                  itemBuilder: (context, index) {
                    final ground = grounds[index];
                    return GroundCard(
                      ground: ground,
                      collectionName:
                          collectionName, // Pass collectionName to GroundCard
                    );
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

class GroundCard extends StatelessWidget {
  final Ground ground;
  final String collectionName; // Accept collectionName as a parameter

  const GroundCard({
    super.key,
    required this.ground,
    required this.collectionName, // Initialize collectionName
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: ground.isAvailable
          ? Colors.green[200]?.withOpacity(0.9)
          : Colors.red[200]?.withOpacity(0.9),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        title: Text(
          ground.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          'Location: ${ground.location}',
          style: const TextStyle(color: Colors.white70),
        ),
        trailing: ground.isAvailable
            ? const Icon(Icons.check_circle, color: Colors.white)
            : const Icon(Icons.cancel, color: Colors.white),
        onTap: ground.isAvailable
            ? () {
                // Navigate to FacilityDetails, passing collectionName and facilityName
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FacilityDetails(
                      facilityName: ground.name,
                      collectionName:
                          collectionName, // Pass collectionName to FacilityDetails
                    ),
                  ),
                );
              }
            : null,
      ),
    );
  }
}

class Ground {
  final String name;
  final String location;
  final bool isAvailable;

  Ground({
    required this.name,
    required this.location,
    required this.isAvailable,
  });
}
