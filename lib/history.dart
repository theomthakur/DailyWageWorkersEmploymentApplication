import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget
{

  final User user;

  const HistoryPage({Key key, this.user}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context)
  {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;


    return Container(

      child:  StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(widget.user.uid).collection("requests").snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot)
        {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          if (!snapshot.hasData) {
            return Container(
              height: h*0.5,

              child: Center(
                child: Text("No history found.",style: TextStyle(fontSize: w*0.055,color:Color(0xff01579b)),),
              ),
            );
          }

          print(snapshot.data.size.toString()+"----------------------");


          return Scaffold
            (

            body: Container(


              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text("Request history : ",style: TextStyle(fontSize: w*0.055,color: Color(0xffE06E50),fontWeight: FontWeight.bold),),
                  ),

                  Expanded(

                    child: ListView(

                      children: snapshot.data.docs.map((DocumentSnapshot document)
                      {

                        print("List vvvvvvvvv----------------------------");

                        return InkWell(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Container(

                              decoration: BoxDecoration(
                                  color: Color(0xff01579b),
                                  borderRadius: BorderRadius.circular(10)
                              ),

                              child: Padding(
                                  padding: EdgeInsets.all(10),

                                  child:Row(

                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                    children: [

                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,

                                        children:
                                        [

                                          Text(document["occupation"],style: TextStyle(fontSize: w*0.046,color: Color(0xffE06E50),fontWeight: FontWeight.bold),),



                                          SizedBox(height: 7,),

                                          Row(
                                            children:
                                            [
                                              Text("Name : ",style: TextStyle(fontSize: w*0.03888,color: Colors.white)),

                                              Text(document["name"],style: TextStyle(fontSize: w*0.03888,color: Color(0xffE06E50),fontWeight: FontWeight.bold)),

                                            ],
                                          ),

                                          SizedBox(height: 7,),

                                          Row(
                                            children:
                                            [
                                              Text("Rate : ",style: TextStyle(fontSize: w*0.03888,color: Colors.white)),

                                              Text("Rs."+document["rate"].toString()+"/day",style: TextStyle(fontSize: w*0.03888,color: Color(0xffE06E50),fontWeight: FontWeight.bold)),

                                            ],
                                          ),



                                          SizedBox(height: 7,),

                                          Row(
                                            children:
                                            [
                                              Text("Phone : ",style: TextStyle(fontSize: w*0.03888,color: Colors.white)),

                                              Text(document["phone"],style: TextStyle(fontSize: w*0.03888,color: Color(0xffE06E50),fontWeight: FontWeight.bold)),

                                            ],
                                          ),

                                          SizedBox(height: 7,),

                                          Row(
                                            children:
                                            [
                                              Text("Email : ",style: TextStyle(fontSize: w*0.03888,color: Colors.white)),

                                              Text(document["email"],style: TextStyle(fontSize: w*0.03888,color: Color(0xffE06E50),fontWeight: FontWeight.bold)),

                                            ],
                                          ),

                                          SizedBox(height: 7,),

                                          Row(
                                            children:
                                            [
                                              Text("Date : ",style: TextStyle(fontSize: w*0.03888,color: Colors.white)),

                                              Text(document["date"],style: TextStyle(fontSize: w*0.03888,color: Color(0xffE06E50),fontWeight: FontWeight.bold)),

                                            ],
                                          ),

                                          SizedBox(height: 7,),

                                          Row(
                                            children:
                                            [
                                              Text("Address : ",style: TextStyle(fontSize: w*0.03888,color: Colors.white)),

                                              Container(
                                                width: 250,
                                                child: (Text(document["address"],style: TextStyle(fontSize: w*0.03888,color: Color(0xffE06E50),fontWeight: FontWeight.bold,),maxLines: 2, overflow: TextOverflow.ellipsis,)),
                                              ),



                                            ],
                                          ),

                                        ],
                                      ),

                                      // Center(
                                      //   child: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                                      // ),

                                    ],
                                  )


                              ),

                            ),
                          ),

                          onTap: ()
                          {

                          },

                        );

                      }).toList(),
                    ),
                  ),


                ],
              ),

            ),
          );




        },

      ),
    );

  }
}
