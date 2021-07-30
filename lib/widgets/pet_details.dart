import 'package:flutter/material.dart';

class Petdetails extends StatefulWidget {
  const Petdetails({ Key? key }) : super(key: key);

  @override
  _PetdetailsState createState() => _PetdetailsState();
}

class _PetdetailsState extends State<Petdetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
            children: [
              IconButton(onPressed:(){
                
              }, icon: Icon(Icons.share)),
              Expanded(
                child: Container(
                  color: Colors.blueGrey[300],
                  
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                ),
              )
            ],
          )),
      );
  }
}