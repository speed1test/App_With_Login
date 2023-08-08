import 'package:all_in_one/activity/home.dart';
import 'package:flutter/material.dart';
import 'package:all_in_one/db/task_model.dart';
import 'package:all_in_one/db/database_helper.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: GreetingScreen(),
      drawer: HomeScreen().buildDrawer(context),
    );
  }
}

class GreetingScreen extends StatefulWidget {
  @override
  _GreetingScreenState createState() => _GreetingScreenState();
}

class _GreetingScreenState extends State<GreetingScreen> {
  final TextEditingController _controller = TextEditingController();
  final DatabaseHelper db = DatabaseHelper.instance;

  List<Greeting> greetings = [];

  @override
  void initState() {
    super.initState();
    _refreshGreetingsList();
  }

  _refreshGreetingsList() async {
    List<Greeting> greetingList = await db.getGreetings();
    setState(() {
      greetings = greetingList;
    });
  }

  _addGreeting(String message) async {
    Greeting newGreeting = Greeting(message: message);
    await db.insertGreeting(newGreeting);
    _refreshGreetingsList();
    _controller.clear();
  }

  _deleteAllGreetings() async {
    await db.deleteAllGreetings();
    _refreshGreetingsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: greetings.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(greetings[index].message),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _controller,
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  _addGreeting(value.trim());
                }
              },
              decoration: InputDecoration(
                hintText: 'Ingresa un mensaje',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _deleteAllGreetings();
            },
            child: Text('Elimina todos los mensajes'),
          ),
        ],
      ),
    );
  }
}