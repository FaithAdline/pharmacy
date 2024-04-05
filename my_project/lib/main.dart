import 'dart:convert';

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

class OrderFormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Form'),
      ),
      body: Center(
        child: Text('Order Form Screen'),
      ),
    );
  }
}
