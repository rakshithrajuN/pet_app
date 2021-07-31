import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:pet_app/authentication/auth.dart';

final Color yellow = Color(0xfffbc31b);
final Color orange = Color(0xfffb6900);

class Formpage extends StatefulWidget {
  @override
  _FormpageState createState() =>
      _FormpageState();
}

class _FormpageState extends State<Formpage> {
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
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_imageFile!.path);
    User? user = await FirebaseAuth.instance.currentUser;
    print(user!.email);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    TaskSnapshot uploadTask = await firebaseStorageRef.putFile(_imageFile!);
     
      if (uploadTask.state == TaskState.success) {
        url = await uploadTask.ref.getDownloadURL();
      
    }
    
    print(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Pet Details'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 111,
              child: ClipRRect(
                     // borderRadius: BorderRadius.circular(20.0),
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
      ),
    );
  }
}
