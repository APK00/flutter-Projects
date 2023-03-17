import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devTools show log;

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
    
     return Scaffold(
      appBar: AppBar(title: const Text('Regiter'),backgroundColor: Colors.blue,foregroundColor: Colors.white,),
        body: Column(
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
                  try
                  {
                     final userCredential=
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: email, 
                    password: password);
                    devTools.log(userCredential.toString());
                  }
                 on FirebaseAuthException catch(e)
                 {
                  if(e.code=='weak-password')
                  {
                    devTools.log('weak-pass');
                  }
                  if(e.code=='email-already-in-use')
                  {
                    devTools.log('email-already-used');
                  }
                 }
                    
                },
                child: const Text('register',
                style: TextStyle(color: Colors.blueAccent),),
                ),
                TextButton(onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login/', 
                    (route) => false);
                }, 
                child:const Text('Back to login view') )
              ],
              ),
     );
  }
}