import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
<<<<<<< HEAD
=======
import 'package:path/path.dart';
import 'package:pet_app/authentication/auth.dart';
>>>>>>> a3782376d0e6e774699dd53e29978a0fb47e22da

final Color yellow = Color(0xfffbc31b);
final Color orange = Color(0xfffb6900);

class Formpage extends StatefulWidget {
  @override
  _UploadingImageToFirebaseStorageState createState() =>
      _UploadingImageToFirebaseStorageState();
}

<<<<<<< HEAD
class _FormpageState extends State<Formpage> {
  var _formkey = GlobalKey<FormState>();
  
  String selectedtype = "dog";
=======
class _UploadingImageToFirebaseStorageState extends State<Formpage> {
  File? _imageFile;
  String? url;

  String? ph;

  ///NOTE: Only supported on Android & iOS
  ///Needs image_picker plugin {https://pub.dev/packages/image_picker}
  final picker = ImagePicker();

  void initState() {
    super.initState();

    // getphone();
  }

  // Future<void> getphone() async {
  //   await auth!.getPhone().then((value) {
  //     setState(() {
  //       ph = value;
  //     });
  //   });
  // }

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_imageFile!.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile!);
    await uploadTask.then((value) {
      setState(() {
        url = value.ref.getDownloadURL().toString();
      });
    });
    print(url);
  }

>>>>>>> a3782376d0e6e774699dd53e29978a0fb47e22da
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Pet Details'),
      ),
<<<<<<< HEAD
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
                              style: TextStyle(color: Colors.grey,fontWeight:FontWeight.bold),
      
                              underline: Container(
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(width: 1.0, style: BorderStyle.solid),
                                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                ),
                            ),
                        value: selectedtype,
                        onChanged: (String? newvalue){
                          setState(() {
                            selectedtype = newvalue!;
                          }
                        
                          );
                        },
                        items: <String>["dog", "cat", "bird", "rabbit"].
                        map<DropdownMenuItem<String>>((String value){
                        
                          return DropdownMenuItem<String>(
                             value: value,
                              child: Text(value),
                                    );
                        }).toList()
                        )        
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Please Enter pet Price";
                          }
                          return null;
                        },
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
                onPressed: () {
                  _formkey.currentState!.validate();
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
=======
      body:  Column(
              children: <Widget>[
               
               
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 200,
                        margin: const EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: _imageFile != null
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
                    ],
                  ),
                ),
                uploadImageButton(context),
              ],
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
                top: 30, left: 20.0, right: 20.0, bottom: 20.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [yellow, orange],
                ),
                borderRadius: BorderRadius.circular(30.0)),
            child: FlatButton(
              onPressed: () => uploadImageToFirebase(context),
              child: Text(
                "Upload Image",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
>>>>>>> a3782376d0e6e774699dd53e29978a0fb47e22da
      ),
    );
  }
}