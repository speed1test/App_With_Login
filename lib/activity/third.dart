import 'package:all_in_one/activity/home.dart';
import 'package:flutter/material.dart';
import 'package:all_in_one/db/task_model.dart';
import 'package:all_in_one/db/database_helper.dart';

class ThirdScreen extends StatefulWidget {
  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final DatabaseHelper db = DatabaseHelper.instance;
  // Lista de opciones de gustos
  List<String> gustos = [
    'Chocolate',
    'Vainilla',
    'Fresa',
    'Menta',
    'Limón',
    'Caramelo',
  ];

  // Variable para almacenar el gusto seleccionado
  String? selectedGusto; // Cambiar el tipo a String?

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pantalla #2')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Selecciona tu gusto favorito:'),
            SizedBox(height: 16),
            // DropdownButton para mostrar la lista de opciones
            DropdownButton<String>(
              value: selectedGusto, // Valor seleccionado actualmente
              onChanged: (String? newValue) {
                setState(() {
                  selectedGusto = newValue; // Actualizar el gusto seleccionado
                });
              },
              items: gustos.map((String gusto) {
                return DropdownMenuItem<String>(
                  value: gusto,
                  child: Text(gusto),
                );
              }).toList(),
            ),
            SizedBox(height: 24),
            // Botón para confirmar la selección
            ElevatedButton(
              onPressed: () {
                if (selectedGusto != null) {
                  _showConfirmationDialog();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Por favor, selecciona un gusto antes de confirmar.')),
                  );
                }
              },
              child: Text('Confirmar selección'),
            ),
          ],
        ),
      ),
      drawer: HomeScreen().buildDrawer(context),
    );
  }

  _addPreferencia(String message) async {
    Preferencia newGreeting = Preferencia(preferenciaMessage: message);
    await db.insertPreferencia(newGreeting);
  }

  // Función para mostrar el diálogo de confirmación
  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmación de selección'),
          content: Text('¿Estás seguro de que quieres elegir "$selectedGusto" como tu gusto favorito?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
                // Aquí puedes realizar acciones adicionales con el gusto seleccionado si lo deseas.
                _addPreferencia("$selectedGusto");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Selección confirmada: "$selectedGusto"')),
                );
              },
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }
}