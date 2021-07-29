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
    return Container(
      color: primaryGreen,
    );
  }
}