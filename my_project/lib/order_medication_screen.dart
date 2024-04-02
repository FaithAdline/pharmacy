import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Utibu Health',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OrderMedicationScreen(),
    );
  }
}

class OrderMedicationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Medication'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the order form screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrderFormScreen()),
            );
          },
          child: Text('Place Order'),
        ),
      ),
    );
  }
}

class OrderFormScreen extends StatefulWidget {
  @override
  _OrderFormScreenState createState() => _OrderFormScreenState();
}

class _OrderFormScreenState extends State<OrderFormScreen> {
  final TextEditingController _medicationController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _medicationController,
              decoration: InputDecoration(labelText: 'Medication'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle order submission
                _submitOrder();
              },
              child: Text('Submit Order'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitOrder() {
    // Here you would implement logic to submit the order to the server
    String medication = _medicationController.text;
    String quantity = _quantityController.text;

    // Placeholder logic to print order details for demonstration purposes
    print('Order placed - Medication: $medication, Quantity: $quantity');

    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Order Confirmation'),
          content: Text('Your order has been placed successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog and navigate back to the previous screen
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
