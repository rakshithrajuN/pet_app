import 'package:flutter/material.dart';
import 'package:pet_app/configuration.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({ Key? key }) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget> [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: primaryGreen),
              accountName: Text("Rakshith Raju N"), 
              accountEmail: Text("rakshithraju2000@gmail.com"),
              
                 ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text("Delete Pet"),
                subtitle: Text("pet"),
                trailing: Icon(Icons.delete),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text("Sign Out"),
                trailing: Icon(Icons.logout_rounded),
              )
          ],
        ),
        
      );
  }
}