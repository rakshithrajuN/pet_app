import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Formpage extends StatefulWidget {
  const Formpage({Key? key}) : super(key: key);

  @override
  _FormpageState createState() => _FormpageState();
}

class _FormpageState extends State<Formpage> {
  var _formkey = GlobalKey<FormState>();
  CollectionReference petusr = FirebaseFirestore.instance.collection('pet');
  String? _petname;
  String? _breed;
  String? _year;
  String? _location;
  String? _type;
  String? _price;

  String selectedtype = "dog";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Pet Details'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.add_a_photo,
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Please Enter pet name";
                          }
                          return null;
                        },
                        
                        onSaved: (value) =>  _petname = value,
                       
                        decoration: const InputDecoration(
                          icon: Icon(Icons.animation),
                          hintText: 'Enter Pet Name',
                          labelText: 'Pet Name *',
                        ),
                        
                      ),
                      
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Please Enter pet breed";
                          }
                          return null;
                        },
                        onSaved: (value) => _breed = value,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          hintText: 'Enter Pet Breed',
                          labelText: 'Pet Breed *',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Please Enter Location";
                          }
                          return null;
                        },
                        onSaved: (value) => _location = value,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.location_city),
                          hintText: 'Enter Pet Location',
                          labelText: 'Location *',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Please Enter Year";
                          }
                          return null;
                        },
                        onSaved: (value) => _year = value,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          hintText: 'Enter year',
                          labelText: 'Year *',
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                            icon: Icon(Icons.keyboard_arrow_down),
                            iconSize: 15,
                            elevation: 16,
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                            underline: Container(
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1.0, style: BorderStyle.solid),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                              ),
                            ),
                            value: selectedtype,
                            onChanged: (String? newvalue) {
                              setState(() {
                                selectedtype = newvalue!;
                              });
                            },
                            items: <String>["dog", "cat", "bird", "rabbit"]
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                                
                              );
                            }).toList())),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Please Enter pet Price";
                          }
                          return null;
                        },
                        onSaved: (value) => _price = value,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          hintText: 'Enter Pet Price',
                          labelText: 'Pet Price *',
                        ),
                      ),
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                onPressed: ()  {
                  _formkey.currentState!.validate();
                   petusr.add({
                                'petname': _petname,
                                'breed':_breed,
                                'year':_year,
                                'location':_location,
                                'price':_price});
                },
                child: Text('Submit'),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                color: Colors.blueAccent,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
