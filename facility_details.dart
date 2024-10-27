import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'payment_page.dart';

class FacilityDetails extends StatelessWidget {
  final String collectionName;
  final String facilityName;

  const FacilityDetails({
    super.key,
    required this.collectionName,
    required this.facilityName,
  });

  Future<Map<String, dynamic>?> fetchFacilityDetails() async {
    final facilityDoc =
        FirebaseFirestore.instance.collection(collectionName).doc(facilityName);
    final snapshot = await facilityDoc.get();
    return snapshot.data();
  }

  void navigateToPaymentPage(BuildContext context, String time) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(
          time: time,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(facilityName),
        backgroundColor: Colors.green[800],
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: fetchFacilityDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Error loading facility data.'));
          }

          final facilityData = snapshot.data!;
          final availability = facilityData['Availability'] ?? false;
          final timeSlots = facilityData.keys.where(
              (key) => key != 'Availability' && facilityData[key] is bool);

          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/volleyball_bg.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                color: Colors.black.withOpacity(0.5),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Availability: ${availability ? 'Available' : 'Unavailable'}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Available Slots:',
                      style: TextStyle(fontSize: 20, color: Colors.white70),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView(
                        children: timeSlots.map((timeSlot) {
                          final isAvailable = facilityData[timeSlot] ?? false;
                          return SlotCard(
                            time: timeSlot,
                            isAvailable: isAvailable,
                            collectionName: collectionName,
                            facilityName: facilityName,
                            onBookingConfirmed: () =>
                                navigateToPaymentPage(context, timeSlot),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Go to Home Screen'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class SlotCard extends StatelessWidget {
  final String time;
  final bool isAvailable;
  final String collectionName;
  final String facilityName;
  final VoidCallback onBookingConfirmed;

  const SlotCard({
    super.key,
    required this.time,
    required this.isAvailable,
    required this.collectionName,
    required this.facilityName,
    required this.onBookingConfirmed,
  });

  Future<void> updateAvailability(bool status) async {
    final facilityDoc =
        FirebaseFirestore.instance.collection(collectionName).doc(facilityName);
    await facilityDoc.update({'Availability': status});
  }

  Future<void> bookTimeSlot(BuildContext context) async {
    final facilityDoc =
        FirebaseFirestore.instance.collection(collectionName).doc(facilityName);

    // Set selected time slot to false (booked)
    await facilityDoc.update({time: false});

    // Check if there are any other available slots
    final updatedData = await facilityDoc.get();
    final slots = updatedData
        .data()
        ?.keys
        .where((key) => key != 'Availability' && updatedData[key] == true);

    // Update the availability based on remaining slots
    final availabilityStatus = slots != null && slots.isNotEmpty;
    await updateAvailability(availabilityStatus);

    // Call the callback to navigate to PaymentPage
    onBookingConfirmed();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: isAvailable
          ? Colors.green[200]?.withOpacity(0.8)
          : Colors.red[200]?.withOpacity(0.8),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          time,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        trailing: isAvailable
            ? const Icon(Icons.check_circle, color: Colors.white)
            : const Icon(Icons.cancel, color: Colors.white),
        onTap: isAvailable
            ? () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Confirm Booking',
                        style: TextStyle(color: Colors.white)),
                    content: Text('Do you want to book the slot at $time?',
                        style: const TextStyle(color: Colors.white)),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel',
                            style: TextStyle(color: Colors.white)),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close dialog
                          bookTimeSlot(context); // Book the slot and notify
                        },
                        child: const Text('Confirm',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                    backgroundColor: Colors.black,
                  ),
                )
            : null,
      ),
    );
  }
}
