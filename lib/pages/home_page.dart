import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  // signUserOut Method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        actions: [
          IconButton(
              onPressed: signUserOut,
              icon: Icon(Icons.logout, color: Colors.white,),
          )
        ],
      ),
      body:
         Container(
           child: Center(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text(
                    "Logged In As: ",
                  style: TextStyle(fontSize: 20),
                         ),
                 SizedBox(
                   height: 10,
                 ),
                 Text(
                   user.email!,
                   style: TextStyle(fontSize: 20),
                 ),

               ],
             ),
           ),
         ),


    );
  }
}
