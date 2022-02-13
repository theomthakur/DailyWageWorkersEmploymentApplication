import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:workers_employment/Worker/workerJobReq.dart';

class WorkerAddJob extends StatefulWidget
{

  final User user;
  final String phone;
  final String name;

  const WorkerAddJob({Key key, this.user, this.phone, this.name}) : super(key: key);

  @override
  _WorkerAddJobState createState() => _WorkerAddJobState();
}

class _WorkerAddJobState extends State<WorkerAddJob>
{
  @override
  Widget build(BuildContext context)
  {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;


    return Container(

      child:  StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('occupations').where("email",isEqualTo:widget.user.email.toString()).snapshots(),
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
                child: Text("No jobs added yet.",style: TextStyle(fontSize: w*0.055,color:Color(0xff01579b)),),
              ),
            );
          }

          print(snapshot.data.size.toString()+"----------------------");


          return Scaffold
            (



            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                backgroundColor: Color(0xffE06E50),
                onPressed: ()
                {

                  TextEditingController _addressController=TextEditingController();
                  TextEditingController _rateController=TextEditingController();
                  TextEditingController _jobController=TextEditingController();
                  TextEditingController _desController=TextEditingController();

                  var now = new DateTime.now();
                  var formatter = new DateFormat('dd-MM-yyyy');
                  String formattedDate = formatter.format(now);

                  showDialog(
                      context: context,
                      builder: (BuildContext context)
                      {

                        return AlertDialog(
                          content: Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              Positioned(
                                right: -40.0,
                                top: -40.0,
                                child: InkResponse(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: CircleAvatar(
                                    child: Icon(Icons.close,color: Colors.white,),
                                    backgroundColor: Color(0xffE06E50),
                                  ),
                                ),
                              ),
                              Form(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextFormField(

                                        decoration: InputDecoration(
                                          labelText: 'Work Skill',
                                          labelStyle: TextStyle(fontSize: w*0.0380,color: Color(0xff19558a),fontWeight: FontWeight.bold),

                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.grey,),
                                          ),

                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Color(0xffE06E50)),
                                          ),

                                        ),
                                        controller: _jobController,


                                      ),
                                    ),



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



                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextFormField(


                                        decoration: InputDecoration(
                                          labelText: 'Location / Area',
                                          labelStyle: TextStyle(fontSize: w*0.0380,color: Color(0xff19558a),fontWeight: FontWeight.bold),

                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.grey,),
                                          ),

                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Color(0xffE06E50)),
                                          ),

                                        ),
                                        controller: _addressController,
                                      ),
                                    ),



                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        // color: Color(0xffE06E50),
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(0xffE06E50),
                                        ),
                                        child: Text("Add",style: TextStyle(color: Colors.white),),
                                        onPressed: ()
                                        {
                                          if (_jobController.text.trim() == "" )
                                          {

                                            Fluttertoast.showToast
                                              (
                                                msg: "Job title should not be empty",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.grey[300],
                                                textColor: Colors.black,
                                                fontSize: w*0.0388
                                            );

                                          }


                                          else if ((_rateController.text.trim() == "" || '.'.allMatches(_rateController.text).length>1))
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

                                          else if(int.parse(_rateController.text.trim())<176)
                                            {
                                              Fluttertoast.showToast
                                                (
                                                  msg: "Daily wage should not be less than Rs. 176",
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.grey[300],
                                                  textColor: Colors.black,
                                                  fontSize: w*0.0388
                                              );
                                            }

                                          else if (_addressController.text.trim() == "") {
                                            Fluttertoast.showToast
                                              (
                                                msg: "Job location should not be empty",
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
                                            print(int.parse(_rateController.text.trim())<176);
                                            FirebaseFirestore.instance.collection("occupations")
                                                .add({

                                              "address":(_addressController.text.trim()),
                                              "occupation":(_jobController.text.trim()),
                                              "rate":double.parse(_rateController.text.trim()),
                                              "email":widget.user.email,
                                              "phone":widget.phone,
                                              "name":widget.name,


                                            });

                                            Navigator.of(context).pop();
                                            setState(() {

                                            });


                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                  );

                }
            ),

            body: Container(


              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text("Add your Work Skill here",style: TextStyle(fontSize: w*0.055,color: Color(0xffE06E50),fontWeight: FontWeight.bold),),
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
                                          Text(document.data()['occupation'],style: TextStyle(fontSize: w*0.046,color: Color(0xffE06E50),fontWeight: FontWeight.bold),),

                                          SizedBox(height: 7,),

                                          Text("Rate : "+"Rs."+document.data()['rate'].toString()+"/day",style: TextStyle(fontSize: w*0.03888,color: Colors.white),),

                                          SizedBox(height: 7,),

                                          Container(
                                            width: 250,
                                            child: (Text(document["address"],style: TextStyle(fontSize: w*0.03888,color: Color(0xffE06E50),fontWeight: FontWeight.bold,),maxLines: 2, overflow: TextOverflow.ellipsis,)),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>WorJobReq(docId: document.id,documentSnapshot: document,)),
                            );
                          },

                          onLongPress: ()
                          {

                            showDialog(
                              context: context,
                              builder: (BuildContext context)
                              {

                                return AlertDialog(

                                  content: Text("Delete this job skill?",style: TextStyle(fontSize: w*0.04104,color: Color(0xff133D62),fontFamily: 'Nunito',fontWeight: FontWeight.bold),),

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
                                        FirebaseFirestore.instance.collection('occupations').doc(document.id).delete();
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );



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

