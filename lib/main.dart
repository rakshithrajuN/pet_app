import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'DrawerScreen.dart';
import 'HomeScreen.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(new MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       home:    Scaffold(
        body: Stack(
          children: [
            DrawerScreen(),
            HomeScreen()
        ],
      )
       )     
    );
      
  }
}
