import 'package:flutter/material.dart';

class Petdetails extends StatefulWidget {
   Petdetails({ Key? key,required this.petname,required this.breed,required this.year }) : super(key: key);
  final String petname;
  final String breed;
  final String year;

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
              Expanded(
                child: Container(
                  color: Colors.blueGrey[300],
                  
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Image.asset('assets/buldog.jpg'),
                ),
              )
            ],
          )),
      );
  }
}