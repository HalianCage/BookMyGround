import 'dart:ui'; // Import for the ImageFilter class
import 'package:flutter/material.dart';
import 'booking_confirmation.dart';

void main() {
  runApp(const PaymentPageDemo());
}

class PaymentPageDemo extends StatelessWidget {
  const PaymentPageDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Payment Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PaymentPage(time: 'NA'),
    );
  }
}

class PaymentPage extends StatefulWidget {
  final String time;

  const PaymentPage({
    super.key,
    required this.time,
  });

  @override
  PaymentPageState createState() => PaymentPageState();
}

class PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();
  String? _paymentMethod = 'Card';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Page'),
        backgroundColor: Colors.green[800], // AppBar color
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/hockey_bg.jpg'), // Background image
                fit: BoxFit.cover, // Cover the entire background
              ),
            ),
          ),
          // Applying blur effect with reduced intensity
          BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 2.0, sigmaY: 2.0), // Reduced blur intensity
            child: Container(
              color: Colors.black.withOpacity(0.5), // Semi-transparent overlay
            ),
          ),
          // The content (form)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Select Payment Method',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white), // White font color
                  ),
                  ListTile(
                    title: const Text(
                      'Pay via Card',
                      style: TextStyle(color: Colors.white), // White font color
                    ),
                    leading: Radio<String>(
                      value: 'Card',
                      groupValue: _paymentMethod,
                      onChanged: (value) {
                        setState(() {
                          _paymentMethod = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'Pay via UPI',
                      style: TextStyle(color: Colors.white), // White font color
                    ),
                    leading: Radio<String>(
                      value: 'UPI',
                      groupValue: _paymentMethod,
                      onChanged: (value) {
                        setState(() {
                          _paymentMethod = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'Pay via PayPal',
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: Radio<String>(
                      value: 'PayPal',
                      groupValue: _paymentMethod,
                      onChanged: (value) {
                        setState(() {
                          _paymentMethod = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'Pay via Google Pay',
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: Radio<String>(
                      value: 'Google Pay',
                      groupValue: _paymentMethod,
                      onChanged: (value) {
                        setState(() {
                          _paymentMethod = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'Pay via Apple Pay',
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: Radio<String>(
                      value: 'Apple Pay',
                      groupValue: _paymentMethod,
                      onChanged: (value) {
                        setState(() {
                          _paymentMethod = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  if (_paymentMethod == 'Card') ...[
                    TextFormField(
                      controller: _cardNumberController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Card Number',
                        hintText: 'XXXX XXXX XXXX XXXX',
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white), // White border
                        ),
                        hintStyle:
                            TextStyle(color: Colors.white), // White hint text
                        labelStyle:
                            TextStyle(color: Colors.white), // White label text
                      ),
                      style: const TextStyle(
                          color: Colors.white), // Input text color
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your card number';
                        }
                        if (value.length != 16) {
                          return 'Card number must be 16 digits';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _expiryDateController,
                            keyboardType: TextInputType.datetime,
                            decoration: const InputDecoration(
                              labelText: 'Expiry Date',
                              hintText: 'MM/YY',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white), // White border
                              ),
                              hintStyle: TextStyle(
                                  color: Colors.white), // White hint text
                              labelStyle: TextStyle(
                                  color: Colors.white), // White label text
                            ),
                            style: const TextStyle(
                                color: Colors.white), // Input text color
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter expiry date';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: TextFormField(
                            controller: _cvvController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'CVV',
                              hintText: 'XXX',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white), // White border
                              ),
                              hintStyle: TextStyle(
                                  color: Colors.white), // White hint text
                              labelStyle: TextStyle(
                                  color: Colors.white), // White label text
                            ),
                            obscureText: true,
                            style: const TextStyle(
                                color: Colors.white), // Input text color
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter CVV';
                              }
                              if (value.length != 3) {
                                return 'CVV must be 3 digits';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ] else if (_paymentMethod == 'UPI') ...[
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'UPI ID',
                        hintText: 'yourupi@bank',
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white), // White border
                        ),
                        hintStyle:
                            TextStyle(color: Colors.white), // White hint text
                        labelStyle:
                            TextStyle(color: Colors.white), // White label text
                      ),
                      style: const TextStyle(
                          color: Colors.white), // Input text color
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your UPI ID';
                        }
                        return null;
                      },
                    ),
                  ],
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Process payment
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingConfirmationScreen(
                              time: widget.time,
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700], // Button color
                    ),
                    child: const Text('Pay Now'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }
}
