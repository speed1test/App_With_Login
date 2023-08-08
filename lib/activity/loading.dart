import 'package:flutter/material.dart';
class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}
class _LoadingState extends State<Loading> {


  void startApp() async
  {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/login',arguments: {
      } );
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    startApp();
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 180,),
              Text("Edwin App",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                ),),
              SizedBox(height: 10,),
              Text("Creado por N1G1 Platform",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white
                ),),
              SizedBox(height: 30,),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.blue[300],

    );
  }
}