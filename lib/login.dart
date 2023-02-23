import 'package:crud_flutter/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController _emailControler = TextEditingController();
  TextEditingController _passwordControler = TextEditingController();
  bool looding = false;

  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registard"),
        centerTitle: true,

      ),
      body: Padding(

        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Login page",style: TextStyle(fontSize: 20),),
                SizedBox(height: 30,),

                TextFormField(
                    controller: _emailControler,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "email"
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please provide email";
                      }
                      return null;
                    }

                ),
                SizedBox(height: 30,)
                ,
                TextFormField(
                  controller:_passwordControler ,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "password"
                  ),validator: (value){
                  if(value!.isEmpty){
                    return "Please provide password";

                  }else if(value.length<6){
                    return "Password must be 6 or more ";
                  }else if(value.length>6){
                    _passwordControler.text = value;
                  }
                  return null ;
                },
                )
                ,
                SizedBox(height: 30,),

                SizedBox(height: 30,),

                looding?CircularProgressIndicator():Container(height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(onPressed: () async {

                    if(_formKey.currentState!.validate()){

                      User? result = await  AuthService().login(_emailControler.text, _passwordControler.text,context);
                      if(result!=null){
                      print("success");

                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>HomePage()), (route) => false);
                      }
                      setState(() {
                        looding =true;
                      });
                    }
                    setState(() {
                      looding = false;
                    });
                  }, child: Text("Login "),),


                ),

                SizedBox(height: 20,),
                OutlinedButton(onPressed: () async {





                },
                    child: Text("Forget password"))


              ],

            ),
          ),
        ),
      ),
    );
  }
}
