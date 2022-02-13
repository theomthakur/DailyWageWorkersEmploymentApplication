

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class CustCarePage extends StatefulWidget {
  const CustCarePage({Key key}) : super(key: key);

  @override
  _CustCarePageState createState() => _CustCarePageState();
}

class _CustCarePageState extends State<CustCarePage>
{
  @override
  Widget build(BuildContext context)
  {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    TextEditingController _feedbackController=TextEditingController();

    return Container(

      // decoration: new BoxDecoration(
      //   image: new DecorationImage(
      //     image: new AssetImage("assets/images/bg_image.png"),
      //     fit: BoxFit.cover,
      //   ),
      // ),

      child: Scaffold(

        backgroundColor: Colors.white,

        appBar: AppBar(
          title: Text("Customer Care",style: TextStyle(fontFamily: 'Nunito',fontWeight: FontWeight.bold),),
          backgroundColor: Colors.lightBlue[900],
          //elevation: 0.0,
        ),

        body: SingleChildScrollView(
          child:Padding(
            padding: EdgeInsets.only(left:10,right:10, top:30),
            child: Column(

              children:
              [

                new Container(
                  child: new Image.asset(
                    "assets/images/custcare.jpg",
                    //height: 60.0,
                    fit: BoxFit.cover,
                  ),
                ),

                Container(

                  decoration: BoxDecoration(
                      color:Colors.lightBlue[900],
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),

                  child: Padding(
                    padding: EdgeInsets.all(25),

                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:
                        [


                          Row(
                            children:
                            [
                              Icon(Icons.call,color: Colors.white,size: w*0.0650,),

                              SizedBox(width: 5,),

                              Text("+917083047990",style: TextStyle(color: Color(0xffE06E50),fontSize: w*0.04,fontWeight: FontWeight.bold,fontFamily: 'Karla')),

                            ],
                          ),



                          Icon(Icons.arrow_forward,size:w*0.0850,color: Colors.white,)

                        ],
                      ),

                      onTap: _launchCaller,
                    ),
                  ),

                ),

                SizedBox(height: 20,),


                Container(

                  decoration: BoxDecoration(
                      color: Colors.lightBlue[900],
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),

                  child: Padding(
                    padding: EdgeInsets.all(25),

                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:
                        [

                          Row(
                            children:
                            [
                              Icon(Icons.email,color: Colors.white,size: w*0.0650,),

                              SizedBox(width: 5,),

                              Text("sarthakvaishnav@gmail.com",style: TextStyle(color: Color(0xffE06E50),fontSize: w*0.04,fontWeight: FontWeight.bold,fontFamily: 'Karla')),

                            ],
                          ),

                          Icon(Icons.arrow_forward,size:w*0.0850,color: Colors.white,)

                        ],
                      ),
                      onTap: _launchEmail,
                    ),
                  ),

                ),

                SizedBox(height: 8,),

              ],
            ),
          ),
        ),

      ),
    );

  }

  _launchCaller() async {
    const url = "tel:+917083047990";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchEmail() async {
    const url = "mailto:sarthakvaishnav@gmail.com";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
