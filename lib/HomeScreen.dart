import 'package:flutter/material.dart';
import 'package:pet_app/configuration.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  double xOffset=0;
  double yOffset=0;
  double scaleFactor=1;
  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)..scale(scaleFactor),
      duration: Duration(milliseconds: 250),
      color: Colors.grey[200],
      child:Column(
        children :[
          SizedBox(
            height:50
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isDrawerOpen?IconButton(icon:Icon(Icons.arrow_back_ios),onPressed: (){
                xOffset=0;
                yOffset=0;
                scaleFactor=1;
                isDrawerOpen=false;
                }):IconButton(icon:Icon(Icons.menu),onPressed: (){
                setState(() {
                  xOffset =250;
                  yOffset = 150;
                  scaleFactor =0.6;
                  isDrawerOpen = true;
                });

              }),

                  Text('Welcome To PET App')
             
            ],
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
              margin: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.search),
                  Text('Search pet to adopt'),
                  Icon(Icons.settings)

                ],
              ),
            ),

            Container(height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context,index){
                return Container(
                  child: Column(
                    children: [
                      Container(

                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: shadowList,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Image.asset(categories[index]['iconPath'],       height: 50,
                          width: 50,color: Colors.grey[700],),
                      ),
                      Text(categories[index]['name'])
                    ],
                  ),
                );
              },

            ),
            ),
        ]
      )
    );
  }
}