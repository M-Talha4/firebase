import 'package:crud_flutter/login.dart';
import 'package:crud_flutter/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class Reg extends StatefulWidget {
  const Reg({Key? key}) : super(key: key);

  @override
  State<Reg> createState() => _RegState();
}

class _RegState extends State<Reg> {

  TextEditingController _emailControler = TextEditingController();
  TextEditingController _passwordControler = TextEditingController();
  TextEditingController _configpasswordControler = TextEditingController();
  bool loading = false;
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
    Text("Sign up page",style: TextStyle(fontSize: 20),),
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
    TextFormField(
    controller: _configpasswordControler,
    decoration: InputDecoration(
    border: OutlineInputBorder(),
    labelText: "confirm password"
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return "Please provide password";
      }else if(value!=_passwordControler.text){
        return "passwod not match";

      }
      return null;
    }


    ),
    SizedBox(height: 30,),
     loading? CircularProgressIndicator(): Container(height: 50,
    width: MediaQuery.of(context).size.width,
    child: ElevatedButton(onPressed: () async {

      if(_formKey.currentState!.validate()){
        print("ok");
        setState(() {
          loading = true;
        });
        User? result =   await  AuthService().registard(_emailControler.text, _passwordControler.text,context);
        if(result!=null){
          print("Success");
          print(result.email);
        }
      }
      setState(() {

        loading =false;
      });
    }, child: Text("Registard"),),

    ),

    SizedBox(height: 20,),
    OutlinedButton(onPressed: () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>
          Login()
      ));
    },
    child: Text("Already have an account? Login here")),


      SizedBox(height: 20,)
      ,
      Divider(),
      SizedBox(height: 20,),

      SignInButton(Buttons.Google,text: "Continue with google", onPressed: (){

      })



    ],

    ),
    ),
    ),
    ),
    );
    }
  }
