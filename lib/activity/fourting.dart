import 'package:all_in_one/activity/home.dart';
import 'package:flutter/material.dart';
import 'package:all_in_one/db/database_helper.dart';

class FourtingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mantenimiento')),
      body: Preferencia(),
      drawer: HomeScreen().buildDrawer(context),
    );
  }
}

class Preferencia extends StatefulWidget {
  @override
  _PreferencesScreenState createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<Preferencia> {
  final TextEditingController _controller = TextEditingController();
  final DatabaseHelper db = DatabaseHelper.instance;

  List<Preferencia> preferencias = [];

  @override
  void initState() {
    super.initState();
  }

  _deleteAllPreferences() async {
    await db.deleteAllPreferences();
  }

  _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Eliminar mensajes'),
          content: Text('¿Estás seguro de que quieres eliminar todos los mensajes?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _deleteAllPreferences();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showConfirmationDialog();
          },
          child: Text('Elimina todos tus preferencias'),
        ),
      ),
    );
  }
}