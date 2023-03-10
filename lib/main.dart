
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/register_view.dart';
import 'package:mynotes/views/verify_email.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage (),
      routes: {
        '/login/':(context)=> const Loginview(),
        '/register/':(context)=> const RegisterView(),
      },
    ));
}
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //return const Placeholder();
    return FutureBuilder(
          future: Firebase.initializeApp(
                options: DefaultFirebaseOptions.currentPlatform,
                ),
          builder: (context, snapshot) {
            switch(snapshot.connectionState) {
             case ConnectionState.done:
               final user=FirebaseAuth.instance.currentUser;
               if (user != null){

                if(user.emailVerified)
                {
                  print('Email verifyed');
                  return const Loginview();
                }else{
                return const VerifyEmailView();
               }

               }else{
                return const Loginview();
               }


               
                
                default:
                return const CircularProgressIndicator();
            }
            
            
          },
        );
  }
}
 



