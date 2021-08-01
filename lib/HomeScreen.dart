import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pet_app/authentication/auth.dart';
import 'package:pet_app/configuration.dart';
import 'package:pet_app/widgets/form_page.dart';
import 'package:pet_app/widgets/pet_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_app/widgets/show.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key,
  required this.auth,required this.onSignOut}) : super(key: key);
  final BaseAuth auth;
  final VoidCallback onSignOut;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignOut();
    } catch (e) {
      print(e);
    }
  }
  bool search = false;
  String filter = '';
  bool dpress = false;
  bool cpress = false;
  bool rpress = false;
  bool bpress = false;
  Color fc = Colors.black;
  TextEditingController searchControler = TextEditingController();

  Widget _buildGride(QuerySnapshot? snapshot) {
    return ListView.builder(
        itemCount: snapshot!.docs.length,
        itemBuilder: (context, index) {
          final doc = snapshot.docs[index];
          print(doc.data());

          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Petdetails(
                            petname: doc['petname'],
                            breed: doc['breed'],
                            year: doc['year'],
                          )));
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
    appBar:AppBar(title:Text('Welcom To Pet App')),
      body: Container(
        child: Column(children: [
          SizedBox(height: 50),
         /* Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 85),
                child: Text('Welcome To PET App'),
              )
            ],
          ),*/
          
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.search),
                SizedBox(
                  width: 190,
                  child: TextField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          search = true;
                        });
                      } else {
                        setState(() {
                          search = false;
                          filter = '';
                          cpress = false;
                          rpress = false;
                          bpress = false;
                          dpress = false;
                        });
                      }
                    },
                    controller: searchControler,
                    decoration: InputDecoration(
                      hintText: "Search Pet Breed to Adopt ",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                     Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Showpage(),
                        ));
                  },
                )
              ],
            ),
          ),
          Container(
            height: 120,
            child: Row(children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    dpress = !dpress;
                    filter = '';
                    cpress = false;
                    rpress = false;
                    bpress = false;
                  });
                  if (dpress) {
                    setState(() {
                      filter = 'dog';
                    });
                  }
                },
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: shadowList,
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.asset(
                          categories[0]['iconPath'],
                          height: 50,
                          width: 50,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        categories[0]['name'],
                        style: TextStyle(
                            color: dpress ? Colors.orange : Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    cpress = !cpress;
                    filter = '';
                    dpress = false;
                    rpress = false;
                    bpress = false;
                  });
                  if (cpress) {
                    setState(() {
                      filter = 'cat';
                    });
                  }
                },
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: shadowList,
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.asset(
                          categories[1]['iconPath'],
                          height: 50,
                          width: 50,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        categories[1]['name'],
                        style: TextStyle(
                            color: cpress ? Colors.orange : Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    bpress = !bpress;
                    filter = '';
                    cpress = false;
                    rpress = false;
                    dpress = false;
                  });
                  if (bpress) {
                    setState(() {
                      filter = 'bird';
                    });
                  }
                },
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: shadowList,
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.asset(
                          categories[2]['iconPath'],
                          height: 50,
                          width: 50,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        categories[2]['name'],
                        style: TextStyle(
                            color: bpress ? Colors.orange : Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    rpress = !rpress;
                    filter = '';
                    cpress = false;
                    dpress = false;
                    bpress = false;
                  });
                  if (rpress) {
                    setState(() {
                      filter = 'rabbit';
                    });
                  }
                },
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: shadowList,
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.asset(
                          categories[3]['iconPath'],
                          height: 50,
                          width: 50,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        categories[3]['name'],
                        style: TextStyle(
                            color: rpress ? Colors.orange : Colors.black),
                      )
                    ],
                  ),
                ),
              ),
            ]),
          ),
          search
              ? StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("pet")
                      .where(
                        'breed',
                        isGreaterThanOrEqualTo: searchControler.text,
                      )
                      .where('breed', isLessThan: searchControler.text + 'z')
                      .snapshots(),
                  builder: (context, snapshot) {
                    // print(snapshot.data);
                    if (!snapshot.hasData) return LinearProgressIndicator();
                    if (snapshot.hasError) return CircularProgressIndicator();
                    return Expanded(child: _buildGride(snapshot.data));
                  },
                )
              : filter != ''
                  ? StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("pet")
                          .where(
                            'pettype',
                            isEqualTo: filter,
                          )
                          .snapshots(),
                      builder: (context, snapshot) {
                        // print(snapshot.data);
                        if (!snapshot.hasData) return LinearProgressIndicator();
                        if (snapshot.hasError) return CircularProgressIndicator();
                        return Expanded(child: _buildGride(snapshot.data));
                      },
                    )
                  : StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("pet")
                          .snapshots(),
                      builder: (context, snapshot) {
                        //print(snapshot.data);
                        if (!snapshot.hasData) return LinearProgressIndicator();
                        if (snapshot.hasError) return CircularProgressIndicator();
                        return Expanded(child: _buildGride(snapshot.data));
                      },
                    ),
                  
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Formpage()));
            },
            child: Icon(Icons.add),
          ),
        ]),
      ),
      drawer: Drawer(
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
                onTap: (){
                  
                       _signOut();
                  
                },

              )
          ],
        ),
        
      ),
    );
  }
}








/*Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration : BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                  child: Row(
                    children: [
                      Image.asset(dogimg[index]['iconPath'],width: 150,) ,
                      SizedBox(
                        width: 70,
                      ),
                      Column(
                        children:[
                          Text(dogimg[index]['name'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          Text(dogimg[index]['breed'],style: TextStyle(fontSize: 10),),
                          Text('2.5 Years')
                        ]
                      )
                    ],
                  ),
                ),
              );*/
                      