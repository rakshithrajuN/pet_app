import 'package:flutter/material.dart';

import 'DrawerScreen.dart';
import 'HomeScreen.dart';

void main(){
  runApp(MaterialApp(home: HomePage(),));
}

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          HomeScreen()
        ],
      )
    );
  }
}