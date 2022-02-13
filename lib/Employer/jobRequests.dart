import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmpJobReq extends StatefulWidget
{

  final String docId;
  final DocumentSnapshot documentSnapshot;

  const EmpJobReq({Key key, this.docId, this.documentSnapshot}) : super(key: key);

  @override
  _EmpJobReqState createState() => _EmpJobReqState();
}

class _EmpJobReqState extends State<EmpJobReq>
{
  @override
  Widget build(BuildContext context)
  {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;




    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color(0xff01579b),
      ),

      body: Padding(
        padding: EdgeInsets.only(left:10,right:10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[

            Text("Job Details:",style: TextStyle(fontSize: 23,color: Color(0xffE06E50),fontWeight: FontWeight.bold),),

            SizedBox(height: 10,),

            Row(
              children:
              [
                Text("Title : ",style: TextStyle(fontSize:w*0.046,color:Colors.black ),),
                Text(widget.documentSnapshot.data()["occupation"],style: TextStyle(fontSize:w*0.046,color:Color(0xff01579b))),

              ],
            ),

            const Divider(
              thickness: 2,
              indent: 10,
              endIndent: 10,
              color: Colors.black,
            ),

            Row(
              children:
              [
                Text("Description : ",style: TextStyle(fontSize:w*0.046,color:Colors.black )),

                Flexible(

                  child:Text(widget.documentSnapshot.data()["description"],overflow: TextOverflow.ellipsis,style: TextStyle(fontSize:w*0.046,color:Color(0xff01579b))),
                )


              ],
            ),

            const Divider(
              thickness: 2,
              indent: 10,
              endIndent: 10,
              color: Colors.black,
            ),

            Row(
              children:
              [
                Text("Address : ",style: TextStyle(fontSize:w*0.046,color:Colors.black )),

                Flexible(child: Text(widget.documentSnapshot.data()["address"],style: TextStyle(fontSize:w*0.046,color:Color(0xff01579b)),maxLines: 4,)),

              ],
            ),

            const Divider(
              thickness: 2,
              indent: 10,
              endIndent: 10,
              color: Colors.black,
            ),

            Row(
              children:
              [
                Text("Rate : ",style: TextStyle(fontSize:w*0.046,color:Colors.black )),

                Text("Rs."+widget.documentSnapshot.data()["rate"].toString()+"/day",style: TextStyle(fontSize:w*0.046,color:Color(0xff01579b))),

              ],
            ),

            const Divider(
              thickness: 2,
              indent: 10,
              endIndent: 10,
              color: Colors.black,
            ),

            SizedBox(height: 10,),


            Text("Job requests below : ",style: TextStyle(fontSize: 23,color: Color(0xffE06E50),fontWeight: FontWeight.bold),),

            SizedBox(height: 10,),




            Flexible(

            child:  StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('jobs').doc(widget.docId).collection("requests").orderBy("rate").snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot)
              {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                if (!snapshot.hasData)
                {
                  return Container(
                    height: h*0.5,

                    child: Center(
                      child: Text("No requests yet.",style: TextStyle(fontSize: 23,color:Color(0xff01579b)),),
                    ),
                  );
                }

                if(snapshot.data.size==0)
                  {

                    return(Column(
                      children: [



                          Container(
                          height: h*0.5,

                          child: Center(
                            child: Text("No requests yet.",style: TextStyle(fontSize: 23,color:Color(0xff01579b)),),
                          ),
                        ),
                      ],
                    ));


                  }


                return Scaffold
                  (

                  body: Container(

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [



                        Expanded(
                          child: ListView(

                            children: snapshot.data.docs.map((DocumentSnapshot document)
                            {

                              return InkWell(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom :10),
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
                                                Text(document.data()['name'],style: TextStyle(fontSize:w*0.046,color: Color(0xffE06E50),fontWeight: FontWeight.bold),),


                                                SizedBox(height: 7,),

                                                Text("Rate - "+"Rs."+document.data()['rate'].toString()+"/day",style: TextStyle(fontSize: w*0.03888,color: Colors.white),),

                                                SizedBox(height: 7,),

                                                Text("Phone - "+document.data()['phone'],style: TextStyle(fontSize: w*0.03888,color: Colors.white),),

                                                SizedBox(height: 7,),

                                                Text("Email - "+document.data()['email'],style: TextStyle(fontSize: w*0.03888,color: Colors.white),),

                                                SizedBox(height: 7,),

                                                Text("Date - "+ document.data()['date'],style: TextStyle(fontSize: w*0.03888,color: Colors.white),),

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
          ),
        ]
        ),
      ),
    );
  }

  _launchCaller(String number) async {
    print(number);
    const url = "tel://7083047880";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}
