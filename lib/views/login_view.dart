import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:mynotes/views/register_view.dart';
import 'package:mynotes/constants/routes.dart';
import '../utilities/show_error_dialog.dart';


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
  Widget build(BuildContext context)  {
    //return const Placeholder();
   return Scaffold(
    appBar: AppBar(title: const Text('Login'),
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,),
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
                TextButton(
                  onPressed:() async {
                  
                  final email= _email.text;
                  final password= _password.text;
                  try{
                    
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email, 
                    password: password,
                    );
                   Navigator.of(context).pushNamedAndRemoveUntil(
                    notesRoute,
                     (route) => false,
                     );

                  }on FirebaseAuthException catch(e)
                  {
                     if(e.code=='user-not-found')
                     {
                      await showErrorDialog(
                        context,
                       'User not found',
                       );
                     }
                     else if(e.code== 'wrong-password')
                     {
                       await showErrorDialog(
                         context,
                        'Wrong credentials',
                        );
                     }else{
                      showErrorDialog(
                        context,
                      'Error: ${e.code}',
                      );

                     }
                  }catch (e){
                   showErrorDialog(
                        context,
                      e.toString(),
                      );
                  }
                  
                
                },
                child: const Text('Login',
                style: TextStyle(color: Colors.blueAccent),),),
                TextButton(onPressed: (){
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      registerRoute, 
                      (route) => false);
                      
                }, 
                child:const Text('Not registered yet? Rigister here'), )
              ],
              ),
   );
  }
  }
 