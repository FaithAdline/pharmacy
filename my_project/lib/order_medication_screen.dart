import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();

  void _sendMessage(BuildContext context) async {
    final String message = _textController.text;

    // Send message via WebSocket
    final channel = IOWebSocketChannel.connect('ws://localhost:3000');
    channel.sink.add(message);

    // Close the channel when done
    channel.sink.close();

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Message sent successfully'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: 'Enter your message here',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                _sendMessage(context);
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.blue, // Change button color here
            ),
            child: Text('Send Message'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderFormScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.blue, // Change button color here
            ),
            child: Text('Place Order'),
          ),
        ],
      ),
    );
  }
}

class OrderFormScreen extends StatefulWidget {
  @override
  _OrderFormScreenState createState() => _OrderFormScreenState();
}

class _OrderFormScreenState extends State<OrderFormScreen> {
  TextEditingController _medicationController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();

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
                _submitOrder();
              },
              child: Text('Submit Order'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitOrder() async {
    String medication = _medicationController.text;
    String quantity = _quantityController.text;

    // HTTP POST request to backend server
    String url = 'http://localhost:3000/place_order';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"medication": "$medication", "quantity": "$quantity"}';

    // Make the request
    final response = await http.post(url, headers: headers, body: json);

    if (response.statusCode == 200) {
      // Order successful, show confirmation
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Order Confirmation'),
            content: Text('Your order has been placed successfully.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Order failed, show error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Order Failed'),
            content: Text('Failed to place order. Please try again later.'),
            actions: [
              TextButton(
                onPressed: () {
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
}
