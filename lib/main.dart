import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/views/register_view.dart';

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
    ));
}
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //return const Placeholder();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('Home',style: TextStyle(
      color: Colors.white54,),),),
        body: FutureBuilder(
          future: Firebase.initializeApp(
                options: DefaultFirebaseOptions.currentPlatform,
                ),
          builder: (context, snapshot) {
            switch(snapshot.connectionState) {
              case ConnectionState.done:
               final user=FirebaseAuth.instance.currentUser;
               
               if(user?.emailVerified ?? false)
               {
                print('you are a verified user');
               }
               else
               {
                print('User isnt verified');
               }
                return const Text ('done');
                default:
                return const Text('Loading.....');
            }
            
            
          },
        ),
    );
  }
}




