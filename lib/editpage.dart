import 'package:crud_flutter/data/user/user_modal.dart';
import 'package:flutter/material.dart';

import 'data/remotedata_store/firebase.dart';
class Editpage extends StatefulWidget {
  final UserModal user ;
  const Editpage({Key? key,required this.user}) : super(key: key);

  @override
  State<Editpage> createState() => _EditpageState();
}

class _EditpageState extends State<Editpage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _nameControler;
  TextEditingController? _ageControler ;
  @override
  void initState() {
    // TODO: implement initState
    _nameControler =TextEditingController(text: widget.user.username);
    _ageControler =TextEditingController(text: widget.user.userage);
    super.initState();

  }
  @override
  void dispose() {
    _ageControler!.dispose();
    _nameControler!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(
      appBar: AppBar(
        title: Text("Edit"),

      ),
      body: Padding(padding: EdgeInsets.all(8),
      child: Column(
        children: [

          SizedBox(height: 100,),

          TextFormField(
            controller: _nameControler,
            decoration: InputDecoration(
                border: OutlineInputBorder()
                ,label: Text("Nmae")
            ),
            validator: (value){
              if(value!.isEmpty){
                return "Please fill name";

              }
              return null ;
            },
          ),
          SizedBox(height: 50,),
          TextFormField(
            controller: _ageControler,
            decoration: InputDecoration(
                border: OutlineInputBorder()
                ,label: Text("Age")
            ),

            validator: (value){
              if(value!.isEmpty ){
                return "Please fill age";

              }
              return null ;
            },
          ),
          SizedBox(height: 50,),

          ElevatedButton(onPressed: (){


            // if(_formKey.currentState!.validate()){
            //   // _create(_nameControler.text.toString(),_ageControler.text.toString());
            //
            //
            //
            //
            //
            // }

            //
            // setState(() {
            //
            //
            // });
            FirebaseHelper.update(UserModal(id: widget.user.id,username: _nameControler!.text,userage: _ageControler!.text)).then((value) {
              Navigator.pop(context);
            });




          }, child:const Text("Update"))
        ],
      ),),
    ));
  }
}
