import 'package:all_in_one/activity/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:all_in_one/db/task_model.dart';
import 'package:all_in_one/db/database_helper.dart';
import 'dart:convert';

class HelloScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('API')),
      body: Hello(),
      drawer: HomeScreen().buildDrawer(context),
    );
  }
}

class Hello extends StatefulWidget {
  @override
  _HelloState createState() => _HelloState();
}

class _HelloState extends State<Hello> {
  String _responseMessage = '';
  final DatabaseHelper db = DatabaseHelper.instance;

  Future<void> _fetchData() async {
    final String apiUrl = 'http://192.168.1.19:8000/auth/hello/';

    final AccessManager? accessManager = await db.getLastAccessManager();
    if (accessManager != null) {
      final String token = accessManager.tokenAccess;

      final Map<String, String> data = {
        'token': token,
      };

      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data),
        );

        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          setState(() {
            _responseMessage = responseData['message'];
          });
        } else {
          setState(() {
            _responseMessage = 'Error: ${response.statusCode}';
          });
        }
      } catch (error) {
        setState(() {
          _responseMessage = 'Error de conexión';
        });
      }
    } else {
      setState(() {
        _responseMessage = 'No se encontró AccessManager';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _fetchData,
              child: Text('Obtener Datos'),
            ),
            SizedBox(height: 20),
            Text(
              _responseMessage,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
