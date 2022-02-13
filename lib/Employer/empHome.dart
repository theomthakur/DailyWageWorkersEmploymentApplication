import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class EmpHomePage extends StatefulWidget
{

  final User user;
  final String phone;
  final String name;


  const EmpHomePage({Key key, this.user, this.phone, this.name}) : super(key: key);

  @override
  _EmpHomePageState createState() => _EmpHomePageState();
}

class _EmpHomePageState extends State<EmpHomePage>
{

  FirebaseAuth mAuth;
  List <String> workList=[];
  String _selectedWork;
  Query query=FirebaseFirestore.instance.collection("occupations").where("occupation",isEqualTo:"Cook");

  Future<void> _getData() async {
    setState(() {
    });
  }

  @override
  Future<void> initState()  {
    super.initState();
    print("Hiii1");
    mAuth=FirebaseAuth.instance;
    getWorkers();

  }

  void getWorkers()
  {
    print("33333333333333333333333333");

    FirebaseFirestore.instance
        .collection('occupations')
        .orderBy("occupation")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc)
      {

        if(!workList.contains(doc["occupation"]))
        {
          workList.add(doc["occupation"]);
        }

      });
      print(workList);
      //_selectedLocation=workList.first;
      setState(() {
        query=FirebaseFirestore.instance.collection("occupations").where("occupation",isEqualTo:workList.first);
        _selectedWork=workList.first;
      });
      //query=FirebaseFirestore.instance.collection("gyms").where("city",isEqualTo:workList.first);
    });


  }


  @override
  Widget build(BuildContext context)
  {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(

        backgroundColor: Colors.transparent,
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.location_pin),
        //   backgroundColor: Theme.of(context).colorScheme.secondary,
        //   onPressed: () {
        //     Navigator.pushNamed(context, 'LocateOnMap');
        //   },
        // ),



        body: Padding(
          padding: EdgeInsets.only(left: 13,right: 13),
          child: Column(
            //mainAxisSize: MainAxisSize.min,

             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                  padding: EdgeInsets.only(top:10),
                  child: Text("Find a Daily wage worker here",style: TextStyle(fontSize: w*0.0729, fontWeight: FontWeight.bold, fontFamily: 'Nunito',color: Colors.black))
              ),


              Padding(
                  padding: EdgeInsets.only(top:10),
                  child: Text("Choose the work",style: TextStyle(fontSize: w*0.0486, fontFamily: 'Nunito',color: Color(0xffE06E50)))
              ),

              Padding(
                padding: EdgeInsets.only(top:10),
                child: Container(

                  decoration: BoxDecoration(

                      color: Colors.blueGrey[100],

                      // border: Border.all(
                      //   color: Colors.black,
                      // ),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),

                  child: Padding(
                    padding:EdgeInsets.only(left:10),
                    child: DropdownButton(
                      hint: Text('Please choose a location'), // Not necessary for Option 1
                      underline: SizedBox(),
                      value: _selectedWork,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedWork = newValue;
                          query=FirebaseFirestore.instance.collection("occupations").where("occupation",isEqualTo:newValue);
                          print(newValue);
                        });
                      },
                      items: workList.map((location) {
                        return DropdownMenuItem(
                          child: new Text(location),
                          value: location,
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),

              SizedBox(height:  15,),

              Container(
                child: SingleChildScrollView(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: query.snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot)
                      {

                        if(!snapshot.hasData)
                        {
                          return Center(child : Text("Loading",style: TextStyle(fontSize:w*0.0486),));
                        }

                        return  Container(
                          child: ListView(

                            //physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: snapshot.data.docs
                                .map((document)
                            {

                              print(document);
                              print("hhhh");

                              return InkWell(

                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xff01579b),
                                        borderRadius: BorderRadius.circular(10)
                                    ),

                                    child: Padding(
                                      padding: EdgeInsets.all(15),

                                      child:Row(

                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(document["name"],style: TextStyle(fontSize: w*0.046,color: Color(0xffE06E50),fontWeight: FontWeight.bold),),


                                              SizedBox(height: 7,),

                                              Row(
                                                children:
                                                [
                                                  Text("Rate : ",style: TextStyle(fontSize:w*0.03888,color: Colors.white)),

                                                  Text("Rs."+document["rate"].toString()+"/day",style: TextStyle(fontSize:w*0.03888,color: Color(0xffE06E50),fontWeight: FontWeight.bold)),

                                                ],
                                              ),

                                              SizedBox(height: 7,),

                                              Row(
                                                children:
                                                [
                                                  Text("Phone : ",style: TextStyle(fontSize:w*0.03888,color: Colors.white)),

                                                  Text(document["phone"],style: TextStyle(fontSize:w*0.03888,color: Color(0xffE06E50),fontWeight: FontWeight.bold)),

                                                ],
                                              ),

                                              SizedBox(height: 7,),

                                              Row(
                                                children:
                                                [
                                                  Text("Email : ",style: TextStyle(fontSize:w*0.03888,color: Colors.white)),

                                                  Text(document["email"],style: TextStyle(fontSize:w*0.03888,color: Color(0xffE06E50),fontWeight: FontWeight.bold)),

                                                ],
                                              ),



                                            ],
                                          ),


                                          Center(
                                            child: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                                          ),


                                        ],
                                      )

                                    ),
                                  ),
                                ),

                                onTap: ()
                                {
                                  var now = new DateTime.now();
                                  var formatter = new DateFormat('dd-MM-yyyy');
                                  String formattedDate = formatter.format(now);

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context)
                                    {

                                      return AlertDialog(

                                        content: Text("Send request to this blue collar?",style: TextStyle(fontSize: w*0.04104,color: Color(0xff133D62),fontFamily: 'Nunito',fontWeight: FontWeight.bold),),

                                        actions: [

                                          ElevatedButton(
                                            child: Text("No"),
                                            style: ElevatedButton.styleFrom(
                                              primary: Color(0xffE06E50),
                                            ),
                                            onPressed: ()
                                            {
                                              Navigator.pop(context);
                                            },
                                          ),

                                          ElevatedButton(
                                            child: Text("Yes"),
                                            style: ElevatedButton.styleFrom(
                                              primary: Color(0xffE06E50),
                                            ),
                                            onPressed: ()
                                            {

                                              FirebaseFirestore.instance.collection('occupations').doc(document.id).collection("requests").doc(widget.user.uid).set(
                                                {
                                                  "name":widget.name,
                                                  "phone":widget.phone,
                                                  "email":widget.user.email,
                                                  "date":formattedDate
                                                });

                                              FirebaseFirestore.instance.collection('users').doc(widget.user.uid).collection("requests").doc(document.id).set(
                                                  {
                                                    "name":document["name"],
                                                    "occupation":document["occupation"],
                                                    "phone":document["phone"],
                                                    "email":document["email"],
                                                    "rate":(document["rate"]),
                                                    "address":document["address"],
                                                    "date":formattedDate
                                                  }).then((value)
                                              {
                                                Fluttertoast.showToast
                                                  (
                                                    msg: "Request send to Blue Collar successfully !",
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.CENTER,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.grey[300],
                                                    textColor: Colors.black,
                                                    fontSize: w*0.0388
                                                );
                                              });





                                              Navigator.pop(context);

                                            },
                                          ),
                                        ],
                                      );

                                    },
                                  );
                                },

                              );

                              // return Container(
                              //   child: !requestedGyms.contains(document.id)?GymTile(gymName: document["gymName"],
                              //     gymState: document["state"],
                              //     gymAdd: document["address"],
                              //     gymCity: document["city"],userGymState: 0,):null,
                              // );

                            }).toList(),
                          ),
                        );
                      }
                  ),
                ),
              ),
            ],
          ),
        )




    );

  }
}


