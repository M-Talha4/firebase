import 'package:crud_flutter/services/auth_services.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Firebase"),
        centerTitle: true,
        backgroundColor: Colors.pink,
        actions: [
          TextButton(onPressed: () async{

            await AuthService().signOut();

            setState(() {


            });
          }, child: Icon(Icons.logout) )
        ],
      ),
    );
  }
}
