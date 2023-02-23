import 'package:crud_flutter/data/remotedata_store/firebase.dart';
import 'package:crud_flutter/data/user/user_modal.dart';
import 'package:crud_flutter/home.dart';
import 'package:crud_flutter/registard.dart';
import 'package:crud_flutter/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'editpage.dart';

Future  main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:  StreamBuilder(
          stream: AuthService().firebaseAuth.authStateChanges(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return HomePage();
            }else{
              return Reg();
            }



          }
          ),
    );
  }
}
class Crud extends StatefulWidget {
  const Crud({Key? key}) : super(key: key);

  @override
  State<Crud> createState() => _CrudState();
}

class _CrudState extends State<Crud> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameControler = TextEditingController();
  TextEditingController _ageControler = TextEditingController();
  @override
  void dispose() {
_ageControler.dispose();
_nameControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
          child: Column(

            children: [
              SizedBox(height: 100,),
              Text("Crud Operations",style: TextStyle(fontSize: 20,color: Colors.blue),),

              SizedBox(height: 50,),
              TextFormField(
                controller: _nameControler,
                decoration: InputDecoration(
                  border: OutlineInputBorder()
                      ,label: Text("Nmae"),
                  hintText: "Enter name"
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return "Please fill name";

                  }
                  return null ;
                },
              ),
              SizedBox(height: 30,),
              TextFormField(
                controller: _ageControler,
                decoration: InputDecoration(
                    border: OutlineInputBorder()
                    ,label: Text("Age"),
                  hintText: "Enter age"
                ),

                validator: (value){
                  if(value!.isEmpty ){
                    return "Please fill age";

                  }
                  return null ;
                },
              ),

              SizedBox(height: 30,),
              Container(

                width: 100,
                height: 40,
                child: ElevatedButton(onPressed: (){
                  if(_formKey.currentState!.validate()){
                    // _create(_nameControler.text.toString(),_ageControler.text.toString());

                    setState(() {
                      FirebaseHelper.create(UserModal(username:_nameControler.text,userage: _ageControler.text ));

                      _nameControler.text="";
                      _ageControler.text="";


                    });




                  }



                }, child:const Text("Add")),
              ),
              ElevatedButton(onPressed: (){

                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                Reg()
                )
                );

              }, child: Text("registard")),
              SizedBox(height: 20,),
          StreamBuilder<List<UserModal>>(
            stream: FirebaseHelper.red(),
            builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }
              if(snapshot.hasError){
                return Center(child: Text("Erroer"),);
              }
              if(snapshot.hasData){

                final userdata = snapshot.data;
                print(userdata!.length);



                return Expanded(child: ListView.builder(itemBuilder: (context, index) {
                  final singaldata =userdata[index];
                  return     Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Card(
                      child: ListTile(
                        onLongPress: (){
                          showDialog(context: context, builder: (context){
                             return AlertDialog(title: Text("Delete"),
                             content: Text("DO you want to delete"),
                               actions: [
                                 ElevatedButton(onPressed: (){
                                print(singaldata.id
                                );
                                   setState(() {

                                     FirebaseHelper.delete(singaldata).then((value){
                                       Navigator.pop(context);
                                     } );

                                   });

                                 }, child: Text("Yes")),

                               ],
                             );
                          });
                        },
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              shape: BoxShape.circle
                          ),
                        ),

                        title: Text("${singaldata.username}"),
                        subtitle: Text("${singaldata.userage}"),
                        trailing: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            Editpage(user: UserModal(
                              username: singaldata.username,userage: singaldata.userage,id: singaldata.id
                            ),)));
                          },
                            child: Icon(Icons.edit)),
                      ),
                    ),
                  );
                },itemCount: userdata.length,
                )
                );

              }
              return Center(child: CircularProgressIndicator(),);

            }
          )


            ],
          ),
        ),
      ),
    );
  }
}



//
// Future  _create(name,age) async {
//
//   final userCollection = FirebaseFirestore.instance.collection("Users");
//   // final docRef = userCollection.doc('user-id');
//   final docRef = userCollection.doc();
//   await docRef.set({
//     "username":"$name",
//     "age":"$age"
//   });
//
// }
