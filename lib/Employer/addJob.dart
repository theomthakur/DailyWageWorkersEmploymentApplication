import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:workers_employment/Employer/jobRequests.dart';

class EmpAddJob extends StatefulWidget 
{
  final User empID;
  final String phone;
  final String name;
  
  const EmpAddJob({Key key, this.empID, this.phone, this.name}) : super(key: key);

  @override
  _EmpAddJobState createState() => _EmpAddJobState();
}

class _EmpAddJobState extends State<EmpAddJob>
{
  @override
  Widget build(BuildContext context)
  {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;


    return Container(

      child:  StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('jobs').orderBy("time",descending: true).where("empID",isEqualTo:widget.empID.uid).snapshots(),
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
                                        labelText: 'Job title',
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


                                      decoration: InputDecoration(
                                        labelText: 'Job description',
                                        labelStyle: TextStyle(fontSize: w*0.0380,color: Color(0xff19558a),fontWeight: FontWeight.bold),

                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey,),
                                        ),

                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xffE06E50)),
                                        ),

                                      ),
                                      controller: _desController,


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
                                        labelText: 'Location',
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

                                        else if (_desController.text.trim() == "" )
                                        {
                                          Fluttertoast.showToast
                                            (
                                              msg: "Job description should not be empty",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.grey[300],
                                              textColor: Colors.black,
                                              fontSize: w*0.0388
                                          );
                                        }

                                        else if (_rateController.text.trim() == "" || '.'.allMatches(_rateController.text).length>1)
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
                                          FirebaseFirestore.instance.collection("jobs")
                                              .add({

                                            "address":(_addressController.text.trim()),
                                            "occupation":(_jobController.text.trim()),
                                            "empID":widget.empID.uid,
                                            "rate":double.parse(_rateController.text.trim()),
                                            "description":_desController.text.trim(),
                                            "time":DateTime.now(),
                                            "email":widget.empID.email,
                                            "phone":widget.phone,
                                            "name":widget.name,


                                          });

                                          Fluttertoast.showToast
                                            (
                                              msg: "Job added successfully !",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.grey[300],
                                              textColor: Colors.black,
                                              fontSize: w*0.0388
                                          );

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
                    child: Text("Add your job requirement here",style: TextStyle(fontSize: w*0.055,color: Color(0xffE06E50),fontWeight: FontWeight.bold),),
                  ),

              Expanded(
                child: ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document)
                  {

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

                            Text("Date : "+DateFormat('dd-MM-yyyy').format(document.data()['time'].toDate()),style: TextStyle(fontSize: w*0.038888,color: Colors.white),),

                            SizedBox(height: 7,),

                            Text("Rate : "+"Rs."+document.data()['rate'].toString()+"/day",style: TextStyle(fontSize: w*0.038888,color: Colors.white),),

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
                        MaterialPageRoute(builder: (context) =>EmpJobReq(docId: document.id,documentSnapshot: document,)),
                      );
                    },

                    onLongPress: ()
                    {

                      showDialog(
                        context: context,
                        builder: (BuildContext context)
                        {

                          return AlertDialog(

                            content: Text("Delete this job?",style: TextStyle(fontSize: w*0.04104,color: Color(0xff133D62),fontFamily: 'Nunito',fontWeight: FontWeight.bold),),

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
                                  FirebaseFirestore.instance.collection('jobs').doc(document.id).delete();
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
