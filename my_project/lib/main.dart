import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    final response = await http.post(
      Uri.parse('http://your_node_server_url.com/send_message'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'message': message}),
    );

    if (response.statusCode == 200) {
      // Successful response, show a success message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Message sent successfully'),
      ));
    } else {
      // Error occurred, show an error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to send message'),
      ));
    }
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
              backgroundColor: Colors.blue, // Change button color here
            ),
            child: Text('Send Message'),
          ),
        ],
      ),
    );
  }
}






  
