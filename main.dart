import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ABCD123',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  Map<String, dynamic>? _response;
  bool _showCharacters = true;
  bool _showNumbers = true;
  bool _showHighestAlphabet = true;

  Future<void> _submitJson() async {
    final String jsonInput = _controller.text;
    try {
      final response = await http.post(
        Uri.parse('https://your-backend-url/bfhl'),
        headers: {'Content-Type': 'application/json'},
        body: jsonInput,
      );
      if (response.statusCode == 200) {
        setState(() {
          _response = json.decode(response.body);
        });
      } else {
        // Handle error
      }
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ABCD123'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              maxLines: 10,
              decoration: InputDecoration(
                hintText: 'Enter JSON',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitJson,
              child: Text('Submit'),
            ),
            SizedBox(height: 16),
            if (_response != null) ...[
              CheckboxListTile(
                title: Text('Characters'),
                value: _showCharacters,
                onChanged: (bool? value) {
                  setState(() {
                    _showCharacters = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Numbers'),
                value: _showNumbers,
                onChanged: (bool? value) {
                  setState(() {
                    _showNumbers = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Highest Alphabet'),
                value: _showHighestAlphabet,
                onChanged: (bool? value) {
                  setState(() {
                    _showHighestAlphabet = value!;
                  });
                },
              ),
              if (_showCharacters)
                Text('Characters: ${_response!['alphabets'].toString()}'),
              if (_showNumbers)
                Text('Numbers: ${_response!['numbers'].toString()}'),
              if (_showHighestAlphabet)
                Text('Highest Alphabet: ${_response!['highest_alphabet'].toString()}'),
            ],
          ],
        ),
      ),
    );
  }
}
