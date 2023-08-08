import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(), // Using LoginScreen as the home widget
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')), // Displaying only the title on the app bar
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoginPage(), // Embedding the LoginPage widget here
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _loginStatus = '';
  String _errorMessage = '';
  int _countdown = 2;
  bool _countdownActive = false;

  Future<void> _login() async {
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Por favor, complete todos los campos.';
      });
      return;
    } else {
      setState(() {
        _errorMessage = '';
      });
    }

    // Verificar la conexión a internet usando connectivity_plus
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      _showNoInternetDialog();
      return;
    }

    final String apiUrl = 'http://192.168.1.19:8000/auth/login/';
    final Map<String, String> data = {
      'username': _usernameController.text,
      'password': _passwordController.text,
      'client_id': 'nE2hSHy0z4h5aifZJdJFwxUjrVGgbffKYboNaF7C',
      'client_secret': 'pbkdf2_sha256\$600000\$Xdgs6cjpfrSn55pNF2WMWE\$l7mDp8I6l1TnbtCCMONaDeEHoanfb4MYQzRTKS8kqxo=',
    };

    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData.containsKey('access_token')) {
        setState(() {
          _loginStatus = 'Login Exitoso';
          _countdownActive = true;
        });

        _startCountdown();
      } else {
        setState(() {
          _loginStatus = 'Error de Login';
          _countdownActive = false;
        });
      }
    } else {
      setState(() {
        _loginStatus = 'Error de Login';
        _countdownActive = false;
      });
    }
  }

  void _startCountdown() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
          _startCountdown();
        } else {
          _countdownActive = false;
          Navigator.pushReplacementNamed(context, '/home');
        }
      });
    });
  }

  void _showNoInternetDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Sin conexión'),
          content: Text('No se detecta una conexión a internet.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 10),
            Text(
              _errorMessage,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _login(),
              child: Text('Login'),
            ),
            SizedBox(height: 20),
            Text(
              _loginStatus,
              style: TextStyle(
                color: _loginStatus == 'Login Exitoso' ? Colors.green : Colors.red,
              ),
            ),
            _countdownActive
                ? SizedBox(height: 20, child: Text('Te llevamos al Home en: $_countdown'))
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
