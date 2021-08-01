import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Showpage extends StatefulWidget {
  const Showpage({Key? key}) : super(key: key);

  @override
  _ShowpageState createState() => _ShowpageState();
}

class _ShowpageState extends State<Showpage> {
  String phone = '';

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

  Widget _buildGride(QuerySnapshot? snapshot) {
    return ListView.builder(
        itemCount: snapshot!.docs.length,
        itemBuilder: (context, index) {
          final doc = snapshot.docs[index];
          print(doc.data());

          return GestureDetector(
            onDoubleTap: () {
              print(doc.id);
              FirebaseFirestore.instance.collection("pet").doc(doc.id).delete();
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Image.network(doc['img'], width: 100, height: 140),
                    SizedBox(
                      width: 70,
                    ),
                    Column(
                      children: [
                        Text(
                          doc['petname'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          doc['breed'],
                          style: TextStyle(fontSize: 10),
                        ),
                        Text(
                          doc['year'],
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Added pets'),
      ),
      body: phone == ''
          ? Center(child: Stack(children:[ CircularProgressIndicator(),SizedBox(width: 100,height: 100,),Text("Double Tap To Delete")]))
          : Center(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("pet")
                    .where('phno', isEqualTo: phone)
                    .snapshots(),
                builder: (context, snapshot) {
                  //print(snapshot.data);
                  if (!snapshot.hasData) return LinearProgressIndicator();
                  if (snapshot.hasError) return CircularProgressIndicator();
                  return Expanded(child: _buildGride(snapshot.data));
                },
              ),
            ),
    );
  }
}
