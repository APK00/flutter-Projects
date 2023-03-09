import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';

class Loginview extends StatefulWidget {
  const Loginview({super.key});

  @override
  State<Loginview> createState() => _LoginviewState();
}

class _LoginviewState extends State<Loginview> {
 late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    //return const Placeholder();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('Login',style: TextStyle(
      color: Colors.white54,),),),
        body: FutureBuilder(
          future: Firebase.initializeApp(
                options: DefaultFirebaseOptions.currentPlatform,
                ),
          builder: (context, snapshot) {
            switch(snapshot.connectionState) {
              case ConnectionState.done:
                return Column(
            children: [
              TextField(
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  hintText: 'please give your E-Mail'
                ),
              ),
              TextField(
                obscureText: true,
                controller: _password,
                enableSuggestions: false,
                autocorrect: false,
                 decoration: const InputDecoration(
                  labelText: 'Password', 
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  hintText: 'please give your password'
                ),
              ),
              TextButton(onPressed:() async {
                
                final email= _email.text;
                final password= _password.text;
                try{
                   final userCredential=
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email, 
                  password: password);
                  print(userCredential);
                  
                }
                on FirebaseAuthException catch(e)
                {
                   if(e.code=='user-not-found')
                   {
                    print('user facked');
                   }
                   if(e.code== 'wrong-password')
                   {
                    print('wrong password');
                   }
                }
                
              
              },
              child: const Text('Login',
              style: TextStyle(color: Colors.blueAccent),),),
            ],
            );
                
                default:
                return const Text('Loading.....');
            }
            
            
          },
        ),
    );
  }
  }