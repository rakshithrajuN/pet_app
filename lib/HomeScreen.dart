import 'package:flutter/material.dart';
import 'package:pet_app/configuration.dart';
import 'package:pet_app/widgets/form_page.dart';
import 'package:pet_app/widgets/pet_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;
 Widget _buildGride(QuerySnapshot? snapshot) {
    return ListView.builder(
        itemCount: snapshot!.docs.length,
        itemBuilder: (context, index) {
          final doc = snapshot.docs[index];
          print(doc.id);
         
          return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Petdetails(petname: doc['petname'],breed: doc['breed'],year: doc['year'],)));
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
                          Image.asset(dogimg[index]['iconPath'],
                              width: 100, height: 140),
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
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor),
      duration: Duration(milliseconds: 250),
      color: Colors.grey[200],
      child: Column(children: [
        SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            isDrawerOpen
                ? IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      setState(() {
                        xOffset = 0;
                        yOffset = 0;
                        scaleFactor = 1;
                        isDrawerOpen = false;
                      });
                    })
                : IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      setState(() {
                        xOffset = 250;
                        yOffset = 150;
                        scaleFactor = 0.6;
                        isDrawerOpen = true;
                      });
                    }),
            Padding(
              padding: const EdgeInsets.only(left: 85),
              child: Text('Welcome To PET App'),
            )
          ],
        ),
       
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.search),
              Text('Search pet to adopt'),
              Icon(Icons.settings)
            ],
          ),
        ),
        Container(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Container(
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
                        categories[index]['iconPath'],
                        height: 50,
                        width: 50,
                        color: Colors.grey[700],
                      ),
                    ),
                    Text(categories[index]['name'])
                  ],
                ),
              );
            },
          ),
        ),

         StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("pet")
                              .snapshots(),
                          builder: (context, snapshot) {
                            print(snapshot.data);
                            if (!snapshot.hasData)
                              return LinearProgressIndicator();
                            if (snapshot.hasError)
                              return CircularProgressIndicator();
                            return Expanded(child: _buildGride(snapshot.data));
                          },
                        ),
                         
        FloatingActionButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> Formpage()));
        },child: Icon(Icons.add),),
      ]),
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
                      