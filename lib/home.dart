import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'main.dart';

class HomePage extends StatefulWidget 
{
  final User user;

  const HomePage({Key key, this.user}) : super(key: key);


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> 
{
  
  FirebaseAuth auth = FirebaseAuth.instance;
   Future<void> _signOut() async 
  {
  await FirebaseAuth.instance.signOut();
  }
  
  @override
  Widget build(BuildContext context) 
  {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
                   .collection('users')                            
                        .doc(widget.user.uid.toString())
                        .snapshots(),
      builder:(context,snapshot)
    {
      String userType=snapshot.data["type"];

      if(snapshot.data["type"]=="")
      {
        return Scaffold
      (
        appBar: AppBar(
          title: Text("Home"),
        ),
        drawer: Drawer(),
        body: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children:[

              Container
              (
                // decoration: new BoxDecoration(
                //       image: new DecorationImage(
                //         image: new AssetImage("assets/images/home.jpg"),
                //         fit: BoxFit.cover,
                //       ),
                //       //border: Border.all(width: 2, color: Colors.blueAccent)
                //     ),
                
                child:Image(image: new AssetImage("assets/images/home.jpg"),)

              ),

              SizedBox(height: 30,),

              Text("Welcome to Worploy", style: TextStyle(fontSize: 35),),

              SizedBox(height:150),

              Text("How can we help you?", style: TextStyle(fontSize: 25),),

              SizedBox(height:30),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children:[

                  InkWell(
                    child: Container
                    (
                      decoration: new BoxDecoration(
                      // image: new DecorationImage(
                      //   image: new AssetImage("assets/images/home3.jpeg"),
                      //   fit: BoxFit.cover,
                      // ),
                      border: Border.all(width: 2, color: Colors.blueAccent)
                    ),

                      child: Text("Become a worker", style: TextStyle(fontSize: 20),),
                    ),

                    onTap: ()
                    {
                      FirebaseFirestore.instance.collection("users").doc(widget.user.uid.toString()).update
                      (
                        {
                          "type":"worker"
                        }
                      );

                      setState(() {

                      });

                       // Navigator.pushReplacement(
                       //          context,
                       //          MaterialPageRoute(builder: (context) =>HomePage(user: widget.user.uid.toString(),)),
                       //        );
                    },
                  ),

                  SizedBox(width:20),


                  InkWell(
                    child: Container
                    (
                      decoration: new BoxDecoration(
                      // image: new DecorationImage(
                      //   image: new AssetImage("assets/images/home3.jpeg"),
                      //   fit: BoxFit.cover,
                      // ),
                      border: Border.all(width: 2, color: Colors.blueAccent)
                    ),

                      child: Text("Find a worker", style: TextStyle(fontSize: 20),),
                    ),

                    onTap: ()
                    {
                      FirebaseFirestore.instance.collection("users").doc(widget.user.uid.toString()).update
                      (
                        {
                          "type":"non-worker"
                        }
                      );

                      // Navigator.pushReplacement(
                      //           context,
                      //           MaterialPageRoute(builder: (context) =>HomePage(homeUserUid: widget.homeUserUid,)),
                      //         );

                      setState(() {

                      });
                    },
                  ),

                ]
              )
            ]
          ),
        )

      );

      }
      
      return Scaffold
      (
        appBar: AppBar(
          title: Text("Home"),
        ),


        drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[

                Container(
                  height: 240,
                                  child: DrawerHeader
                  (
                    decoration: BoxDecoration
                    (
                      color: Colors.blue,
                      //F9E79F, A9DFBF, 85C1E9, FADBD8, #81D4FA
                    ),

                    child: Column
                    (
                      crossAxisAlignment: CrossAxisAlignment.start,
                     
                      children:
                      [

                        Container
                        (
                          child: Center
                          (
                            child: Icon(Icons.account_circle,size: 100,)
                          )
                        ),
                        Text(snapshot.data["name"],style: TextStyle(fontSize:18),),
                        //Text(widget._userName,style: TextStyle(fontSize:17),),
                        Text(snapshot.data["email"],style: TextStyle(fontSize:18),),
                        //Text(widget._userEmail,style: TextStyle(fontSize:17),),
                        Text(snapshot.data["phone"],style: TextStyle(fontSize:18),),
                        //Text(widget._userPhoneNumber,style: TextStyle(fontSize:17),),
                      ]
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top:4,left:3),
                                  child: ListTile(
                    leading: Icon(Icons.home,size: 40,color: Colors.black,),
                    title: Text('Home',style: TextStyle(fontSize: 18)),
                    onTap: () 
                    {
                    },
                  ),
                ),

               

                // Padding(
                //   padding: EdgeInsets.only(top:20,left:3),
                //   child: ListTile(
                //            leading: Container
                //            (
                //              height: 40,
                //              width: 40,
                //              child: Image.asset("assets/images/.png",)
                //             ),
                //     title: Text('',style: TextStyle(fontSize: 18)),
                //     onTap: () 
                //     {
                //     },
                //   ),
                // ),

                Padding(padding: EdgeInsets.only(top:20,left:3),
                                  child: ListTile(
                    leading: Icon(Icons.logout,size: 40,color: Colors.black,),
                    title: Text('Logout',style: TextStyle(fontSize: 18)),
                    
                    onTap: () 
                    {
                       _signOut();

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => MyApp()),
                              );

                    },
                  ),
                ),


              ],
            ),
          ),



        body: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children:[

              Container
              (
                // decoration: new BoxDecoration(
                //       image: new DecorationImage(
                //         image: new AssetImage("assets/images/home.jpg"),
                //         fit: BoxFit.cover,
                //       ),
                //       //border: Border.all(width: 2, color: Colors.blueAccent)
                //     ),
                
                child:Image(image: new AssetImage("assets/images/home.jpg"),)

              ),
              SizedBox(height: 30,),

              Text("Welcome to Worploy", style: TextStyle(fontSize: 35),),

              SizedBox(height:150),

              Text("You are a "+userType,style: TextStyle(fontSize: 25),),

      
            ]
          ),
        )

      );
      
    }
    );
  }
}