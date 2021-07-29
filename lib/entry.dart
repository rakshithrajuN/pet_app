import 'package:flutter/material.dart';
import 'DrawerScreen.dart';
import 'HomeScreen.dart';
import 'authentication/auth.dart';

class EntryPage extends StatefulWidget {
  EntryPage({ required this.auth, required this.onSignOut});
  
  final BaseAuth auth;
  final VoidCallback onSignOut;
  @override
  _EntryPageState createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {

  void _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignOut();
    } catch (e) {
      print(e);
    }
  }

  void _googlesignOut() async {
    try {
      await widget.auth.signOutGoogle();
      widget.onSignOut();
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(child:Text("sigout"),
        onPressed:() {
                       _signOut();
                    }
                    ),
        body: Stack(
      children: [
        DrawerScreen(),
         HomeScreen()
         ],
    ));
  }
}
