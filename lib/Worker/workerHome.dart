import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class WorkerHomePage extends StatefulWidget
{
  final User user;
  final String phone;
  final String name;


  const WorkerHomePage({Key key, this.user, this.phone, this.name}) : super(key: key);

  @override
  _WorkerHomePageState createState() => _WorkerHomePageState();
}

class _WorkerHomePageState extends State<WorkerHomePage>
{

  FirebaseAuth mAuth;
  List <String> workList=[];
  String _selectedWork;
  Query query=FirebaseFirestore.instance.collection("jobs").where("occupation",isEqualTo:"Gardener");

  @override
  Future<void> initState()  {
    super.initState();
    print("Hiii1");
    mAuth=FirebaseAuth.instance;
    getJobs();
  }

  void getJobs()
  {
    print("33333333333333333333333333");

    FirebaseFirestore.instance
        .collection('jobs')
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
        query=FirebaseFirestore.instance.collection("jobs").where("occupation",isEqualTo:workList.first);
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
                  child: Text("Find your Contractor here",style: TextStyle(fontSize: w*0.0729, fontWeight: FontWeight.bold, fontFamily: 'Nunito',color: Colors.black))
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
                          query=FirebaseFirestore.instance.collection("jobs").where("occupation",isEqualTo:newValue);
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

                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: snapshot.data.docs
                                .map((document)
                            {

                              print(document);
                              print("hhhh");

                              return InkWell(

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
                                                  Text("Rate : ",style: TextStyle(fontSize: w*0.03888,color: Colors.white)),

                                                  Text("Rs."+document["rate"].toString()+"/day",style: TextStyle(fontSize: w*0.03888,color: Color(0xffE06E50),fontWeight: FontWeight.bold)),

                                                ],
                                              ),

                                              SizedBox(height: 7,),

                                              Row(
                                                children:
                                                [
                                                  Text("Date : ",style: TextStyle(fontSize: w*0.03888,color: Colors.white)),

                                                  Text(DateFormat('dd-MM-yyyy').format(document.data()['time'].toDate()),style: TextStyle(fontSize: w*0.03888,color: Color(0xffE06E50),fontWeight: FontWeight.bold),),

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
                                                  Text("Address : ",style: TextStyle(fontSize: w*0.03888,color: Colors.white)),

                                                  Container(
                                                    width: 250,
                                                    child: (Text(document["address"],style: TextStyle(fontSize: w*0.03888,color: Color(0xffE06E50),fontWeight: FontWeight.bold,),maxLines: 2, overflow: TextOverflow.ellipsis,)),
                                                  ),



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

                                onTap: ()
                                {
                                  var now = new DateTime.now();
                                  var formatter = new DateFormat('dd-MM-yyyy');
                                  String formattedDate = formatter.format(now);

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context)
                                    {

                                      TextEditingController _rateController=TextEditingController();

                                      return AlertDialog(

                                        content:Stack(
                                          overflow: Overflow.visible,
                                          children: <Widget>[
                                            // Positioned(
                                            //   right: -40.0,
                                            //   top: -40.0,
                                            //   child: InkResponse(
                                            //     onTap: () {
                                            //       Navigator.of(context).pop();
                                            //     },
                                            //     child: CircleAvatar(
                                            //       child: Icon(Icons.close,color: Colors.white,),
                                            //       backgroundColor: Color(0xffE06E50),
                                            //     ),
                                            //   ),
                                            // ),
                                            Form(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[

                                                  Padding(
                                                    padding: EdgeInsets.all(8.0),
                                                    child: TextFormField(

                                                      keyboardType: TextInputType.numberWithOptions(
                                                        decimal: false,
                                                        signed: false,
                                                      ),


                                                      decoration: InputDecoration(
                                                        labelText: 'Rate/day',
                                                        labelStyle: TextStyle(fontSize: w*0.0380,color: Color(0xff19558a),fontWeight: FontWeight.bold),

                                                        enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(color: Colors.grey,),
                                                        ),

                                                        focusedBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(color: Color(0xffE06E50)),
                                                        ),

                                                      ),
                                                      controller: _rateController,

                                                    ),
                                                  ),


                                                ],
                                              ),
                                            ),
                                          ],
                                        ),

                                       // content: Text("Send request for this job?",style: TextStyle(fontSize: w*0.04104,color: Color(0xff133D62),fontFamily: 'Nunito',fontWeight: FontWeight.bold),),

                                        actions: [

                                          ElevatedButton(
                                            child: Text("Cancel"),
                                            style: ElevatedButton.styleFrom(
                                              primary: Color(0xffE06E50),
                                            ),
                                            onPressed: ()
                                            {
                                              Navigator.pop(context);
                                            },
                                          ),

                                          ElevatedButton(
                                            child: Text("Send"),
                                            style: ElevatedButton.styleFrom(
                                              primary: Color(0xffE06E50),
                                            ),
                                            onPressed: ()
                                            {

                                              if (_rateController.text.trim() == "" || '.'.allMatches(_rateController.text).length>1)
                                                {
                                                  Fluttertoast.showToast
                                                    (
                                                      msg: "Job rate should not be empty and contain at max 1 decimal",
                                                      toastLength: Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.CENTER,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor: Colors.grey[300],
                                                      textColor: Colors.black,
                                                      fontSize: w*0.0388
                                                  );
                                                }

                                             else
                                                {

                                                  FirebaseFirestore.instance.collection('jobs').doc(document.id).collection("requests").doc(widget.user.uid).set(
                                                      {
                                                        "name":widget.name,
                                                        "phone":widget.phone,
                                                        "email":widget.user.email,
                                                        "rate":double.parse(_rateController.text.trim()),
                                                        "date":formattedDate
                                                      }).then((value)
                                                  {
                                                    Fluttertoast.showToast
                                                      (
                                                        msg: "Request send to Employer successfully !",
                                                        toastLength: Toast.LENGTH_SHORT,
                                                        gravity: ToastGravity.CENTER,
                                                        timeInSecForIosWeb: 1,
                                                        backgroundColor: Colors.grey[300],
                                                        textColor: Colors.black,
                                                        fontSize: w*0.0388
                                                    );
                                                  });

                                                  FirebaseFirestore.instance.collection('users').doc(widget.user.uid).collection("requests").doc(document.id).set(
                                                      {
                                                        "name":document["name"],
                                                        "occupation":document["occupation"],
                                                        "phone":document["phone"],
                                                        "email":document["email"],
                                                        "rate":double.parse(_rateController.text.trim()),
                                                        "address":document["address"],
                                                        "date":formattedDate
                                                      });

                                                  Navigator.pop(context);


                                                }








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
