import 'package:firebase_database/firebase_database.dart';

class UserModel{

  String? id;
  String? email;
  String? name;
  String? lname;
  String? pw;
  String? phone;

   UserModel({ required this.id,required this.email,required this.name,required this.phone,this.lname,this.pw});

   UserModel.fromSnapshot(DataSnapshot dataSnapshot){
     id=dataSnapshot.key!;
     email=(dataSnapshot.value as dynamic)["email"];
     name=(dataSnapshot.value as dynamic)["name"];
     phone=(dataSnapshot.value as dynamic)["phone"];
   }

}