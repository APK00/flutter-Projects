
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/register_view.dart';
import 'package:mynotes/views/verify_email.dart';
import 'firebase_options.dart';
import 'dart:developer'as devTools show log;

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
        loginRoute:(context)=> const Loginview(),
        registerRoute:(context)=> const RegisterView(),
        notesRoute:(context) => const NotesView(),
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
                  devTools.log('Email verifyed');
                  return const NotesView();
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
enum MenuAction{ logout ,details }
 class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Menu UI'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected:(value) async {
              switch (value){

                case MenuAction.logout:
                  final shouldLogOut= await showLogOutDialog(context);
                  if(shouldLogOut){
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute,
                       (_) => false,
                       );
                  }
                  devTools.log(shouldLogOut.toString());
                  break;
                case MenuAction.details:
                  devTools.log(toString());
                  break;
              }
            
          },itemBuilder: (context) {
            return const[
              PopupMenuItem<MenuAction>(
              value:MenuAction.logout ,
              child:Text('Logout'),
              
            ),
            PopupMenuItem<MenuAction>(
              value:MenuAction.details ,
              child:Text('Details'),
              
            ),
            ];
           
          }, )
        ],
        ),
        body: const Text('Hello dear'),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context){
  return showDialog(context: context, builder: (context){
    return AlertDialog (
      title:const Text('Sign out'),
      content: const Text('Are you sure you want to sign out?'),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop(false);
        },child: const Text('Cancel')),
        TextButton(onPressed: (){
           Navigator.of(context).pop(true);
        },child: const Text('Logout'), )
      ],
    ); 
  },
  ).then((value) => value ?? false);
}

