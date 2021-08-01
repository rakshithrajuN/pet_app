import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:pet_app/authentication/auth.dart';

final Color yellow = Color(0xfffbc31b);
final Color orange = Color(0xfffb6900);

class Formpage extends StatefulWidget {
  const Formpage({Key? key}) : super(key: key);

  @override
  _FormpageState createState() => _FormpageState();
}

class _FormpageState extends State<Formpage> {
  File? _imageFile;
  String? url;

  String? ph;
  var _formkey = GlobalKey<FormState>();
  CollectionReference petusr = FirebaseFirestore.instance.collection('pet');
  String? _petname;
  String? _breed;
  String? _year;
  String? _location;
  String? _type;
  String? _price;
  bool pick = false;
  bool imageload = false;
  String selectedtype = "dog";
  String phone = '';
  bool load = false;

  ///NOTE: Only supported on Android & iOS
  ///Needs image_picker plugin {https://pub.dev/packages/image_picker}
  final picker = ImagePicker();

  void initState() {
    super.initState();

    getPhone();
  }

  void getPhone() async {
    User? user = await FirebaseAuth.instance.currentUser;
    print(user);
    String? ph = '';
    await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .get()
        .then((value) {
      ph = value.get('phone');
      print(phone);
    });
    if (ph != '') {
      setState(() {
        phone = ph.toString();
      });
    }
    print(phone);
  }

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      pick = true;
      _imageFile = File(pickedFile!.path);
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    setState(() {
      imageload = true;
    });
    String fileName = basename(_imageFile!.path);
    User? user = await FirebaseAuth.instance.currentUser;
    print(user!.email);
    String? ur;
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    TaskSnapshot uploadTask = await firebaseStorageRef.putFile(_imageFile!);

    if (uploadTask.state == TaskState.success) {
      ur = await uploadTask.ref.getDownloadURL();

      setState(() {
        url = ur;
        imageload = false;
      });
    }

    print(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Pet Details'),
      ),
      body: load
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 111,
                          child: ClipRRect(
                            // borderRadius: BorderRadius.circular(20.0),
                            child: imageload
                                ? Center(child: CircularProgressIndicator())
                                : _imageFile != null
                                    ? Image.file(_imageFile!)
                                    : FlatButton(
                                        child: Icon(
                                          Icons.add_a_photo,
                                          size: 50,
                                        ),
                                        onPressed: pickImage,
                                      ),
                          ),
                        ),
                        uploadImageButton(context),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
                              onSaved: (value) => _petname = value,
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
                                            width: 1.0,
                                            style: BorderStyle.solid),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                  value: selectedtype,
                                  onChanged: (String? newvalue) {
                                    setState(() {
                                      selectedtype = newvalue!;
                                    });
                                  },
                                  items: <String>[
                                    "dog",
                                    "cat",
                                    "bird",
                                    "rabbit"
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
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
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: RaisedButton(
                              onPressed: () {
                                final form = _formkey.currentState;
                                _formkey.currentState!.validate();
                                if (form!.validate() && url != '') {
                                  setState(() {
                                    load = true;
                                  });
                                  form.save();
                                  print(
                                      "$_petname\n$_breed\n$_year\n$_location\n$_price");
                                  petusr.add({
                                    'img':
                                        'https://firebasestorage.googleapis.com/v0/b/petapp-974cf.appspot.com/o/uploads%2Fimage_picker4197855398797668370.jpg?alt=media&token=105e6d70-b210-4046-a798-cc5fdc2c7997',
                                    'petname': _petname,
                                    'phno': phone,
                                    'breed': _breed,
                                    'year': _year,
                                    'location': _location,
                                    'price': _price
                                  }).then((value) {
                                    Navigator.pop(context);
                                  });
                                }
                              },
                              child: Text('Submit'),
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80.0)),
                              color: Colors.blueAccent,
                            ),
                          )
                        ],
                      )),
                ]),
              ),
            ),
    );
  }

  Widget uploadImageButton(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
            margin: const EdgeInsets.only(
                top: 30, left: 20.0, right: 20.0, bottom: 0.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [yellow, orange],
                ),
                borderRadius: BorderRadius.circular(30.0)),
            child: FlatButton(
                child: Text(
                  "Upload Image",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  pick ? uploadImageToFirebase(context) : null;
                }),
          ),
        ],
      ),
    );
  }
}
