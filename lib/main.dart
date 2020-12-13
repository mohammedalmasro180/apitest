import 'dart:convert';

import 'package:apitest/product.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Product> _notes = List<Product>()
  ;
  Future<List<Product>> fetchNotes() async {
    String username = 'BC779QASLN6E5BSVU7RX962UW6U6QF6C';
    String password = ':';
    String auth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    print(auth);
    http.Response response = await http.get(
        'https://p3ly.com/api/products/1?output_format=JSON',
        headers: <String, String>{'authorization': auth,});

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        _notes.add(Product.fromJson(noteJson));
      }
    }
    return _notes;
  }

  @override
  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _notes.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter listview with json'),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.only(top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _notes[index].name,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      _notes[index].name,
                      style: TextStyle(
                          color: Colors.grey.shade600
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: _notes.length,
        )
    );
  }
}
