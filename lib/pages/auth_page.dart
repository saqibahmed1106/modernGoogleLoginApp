import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_google_signin/pages/home_page.dart';
import 'package:new_google_signin/pages/login_page.dart';

import 'login_or_register_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
        //   user is logged in

          if(snapshot.hasData){
            return HomePage();
          }

        //   user in not logged in

          else{
           return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
