import 'package:flutter/material.dart';
import 'package:all_in_one/db/task_model.dart';
import 'package:all_in_one/db/database_helper.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Preferencias')),
      body: getPreferencia(),
      drawer: buildDrawer(context),
    );
  }

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 240,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  new UserAccountsDrawerHeader(
                    margin: EdgeInsets.zero,
                    accountName: new Text('Pablo'),
                    accountEmail: new Text('pablo@email.com'),
                    currentAccountPicture: new CircleAvatar(
                      backgroundImage: new AssetImage('images/avatar.jpeg'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          ListTile(
            title: Text('Chat'),
            onTap: () {
              Navigator.pushNamed(context, '/second');
            },
          ),
          ListTile(
            title: Text('Preferencias'),
            onTap: () {
              Navigator.pushNamed(context, '/third');
            },
          ),
          ListTile(
            title: Text('Mantenimiento'),
            onTap: () {
              Navigator.pushNamed(context, '/fourting');
            },
          ),
          ListTile(
            title: Text('API'),
            onTap: () {
              Navigator.pushNamed(context, '/hello');
            },
          ),
        ],
      ),
    );
  }
}

class getPreferencia extends StatefulWidget {
  @override
  _PreferencesScreenState createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<getPreferencia> {
  final TextEditingController _controller = TextEditingController();
  final DatabaseHelper db = DatabaseHelper.instance;

  List<Preferencia> preferencias = [];

  @override
  void initState() {
    super.initState();
    _refreshGreetingsList();
  }

  _refreshGreetingsList() async {
    List<Preferencia> preferenciaList = await db.getPreferencias();
    setState(() {
      preferencias = preferenciaList;
    });

    // Check if the index is zero and show the alert dialog
    if (preferencias.isEmpty) {
      _showZeroIndexAlert();
    }
  }

  _showZeroIndexAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Aviso'),
          content: Text('No tienes preferencias registradas en la app.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: preferencias.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(preferencias[index].preferenciaMessage),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}