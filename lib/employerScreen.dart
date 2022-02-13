import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:workers_employment/Employer/empHome.dart';
import 'package:workers_employment/login.dart';

import 'Employer/addJob.dart';
import 'customerCare.dart';
import 'history.dart';

class EmpScreen extends StatefulWidget
{
  final User user;
  final String name;
  final String phone;

  const EmpScreen({Key key, this.user, this.name, this.phone}) : super(key: key);

  @override
  _EmpScreenState createState() => _EmpScreenState();
}

class _EmpScreenState extends State<EmpScreen>
{

  static User user2;
  static String name2;
  static String phone2;

  @override
  void initState() {
    super.initState();
    user2 = widget.user;
    name2=widget.name;
    phone2=widget.phone;

  }

  int _selectedIndex = 1;
  static TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static  List<Widget> _widgetOptions = <Widget>
  [

    EmpAddJob(empID: user2,phone: phone2,name: name2,),

    EmpHomePage(user: user2,name:name2 ,phone: phone2,),

    HistoryPage(user: user2,),
  ];

  void _onItemTapped(int index)
  {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context)
  {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(

      backgroundColor: Colors.white,


      drawer:FutureBuilder<DocumentSnapshot>
        (
          future: FirebaseFirestore.instance.collection("users").doc(widget.user.uid).get(),
          builder:  (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot)
          {


            if(snapshot.hasError)
            {
              return Text("Something went wrong");
            }

            if (snapshot.connectionState == ConnectionState.done)
            {
              // TextEditingController _heightController=TextEditingController(text: snapshot.data["height"].toString());
              // TextEditingController _weightController=TextEditingController(text: snapshot.data["weight"].toString());
              // TextEditingController _bmiController=TextEditingController(text: snapshot.data["bmi"].toString());
              // TextEditingController _fatController=TextEditingController(text: snapshot.data["bodyFat"].toString());

              return Drawer(
                // Add a ListView to the drawer. This ensures the user can scroll
                // through the options in the drawer if there isn't enough vertical
                // space to fit everything.

                child: Container(

                  decoration: BoxDecoration(
                    //color: Color(0xff19558a),

                  ),

                  child: ListView(
                    // Important: Remove any padding from the ListView.

                    padding: EdgeInsets.zero,

                    children: <Widget>
                    [

                      Container(
                        height: h*0.2964,
                        child: DrawerHeader(

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height:h*0.11856, //100
                                width: w*0.2430,//100

                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,



                                ),
                                child: Icon(Icons.person,size: w*0.12152,),//w=50

                              ),

                              Text(snapshot.data.get("name"),style: TextStyle(fontSize: w*0.0486,color: Colors.white,fontFamily: 'Karla',fontWeight: FontWeight.bold),),

                              Text("+91 "+snapshot.data.get("phone"),style: TextStyle(fontSize: w*0.03645,color: Colors.white,fontFamily: 'Nunito',fontWeight: FontWeight.bold),),


                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xff19558a),
                            // borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),


                      ListTile(
                        // visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                        dense: true,
                        //contentPadding: EdgeInsets.symmetric( vertical: 0.0),
                        title: Text('About Us',style: TextStyle(fontSize: w*0.0437,color:Colors.black,fontFamily: 'Karla')),
                        //subtitle: Text(snapshot.data["RFID"],style: TextStyle(fontSize: w*0.0388,color: Colors.black,fontFamily: 'Karla')),

                        trailing: Icon(Icons.business_center,color:Color(0xff01579b),size: w*0.0829,),

                        onTap:_launchAbout,
                      ),

                      const Divider(
                        thickness: 2,
                        indent: 10,
                        endIndent: 10,
                        color: Color(0xff01579b),
                      ),

                      ListTile(
                        //visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                        dense: true,
                        //contentPadding: EdgeInsets.symmetric( vertical: 0.0),
                        title: Text('Feedback',style: TextStyle(fontSize: w*0.0437,color: Colors.black,fontFamily: 'Karla')),
                        //subtitle: Text(snapshot.data["RFID"],style: TextStyle(fontSize: w*0.0388,color: Colors.black,fontFamily: 'Karla')),

                        trailing: Icon(Icons.feedback,color:Color(0xff01579b),size: w*0.0829,),

                        onTap: ()
                        {

                          var now = new DateTime.now();
                          var formatter = new DateFormat('dd-MM-yyyy');
                          String formattedDate = formatter.format(now);

                          TextEditingController _feedbackController=TextEditingController();

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

                                                maxLines: 3,
                                                keyboardType: TextInputType.multiline,




                                                decoration: InputDecoration(
                                                  //labelText: 'Feedback',
                                                  labelStyle: TextStyle(fontSize: w*0.0380,color: Color(0xff19558a),fontWeight: FontWeight.bold),

                                                  hintText: "Feedback",

                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.grey,),
                                                  ),

                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(color: Color(0xffE06E50)),
                                                  ),

                                                ),
                                                controller: _feedbackController,


                                              ),
                                            ),




                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: ElevatedButton(
                                                // color: Color(0xffE06E50),
                                                style: ElevatedButton.styleFrom(
                                                  primary: Color(0xffE06E50),
                                                ),
                                                child: Text("Send",style: TextStyle(color: Colors.white),),
                                                onPressed: ()
                                                {
                                                  if (_feedbackController.text.trim() == "" )
                                                  {

                                                    Fluttertoast.showToast
                                                      (
                                                        msg: "Feedback should not be empty",
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
                                                    FirebaseFirestore.instance.collection("feedback")
                                                        .add({
                                                      "name":widget.name,
                                                      "id":widget.user.uid,
                                                      "feedback":_feedbackController.text.toString().trim(),
                                                      "date":formattedDate,

                                                    }).then((value) =>
                                                    {
                                                      Fluttertoast.showToast
                                                        (
                                                          msg: "Feedback sent successfully !",
                                                          toastLength: Toast.LENGTH_SHORT,
                                                          gravity: ToastGravity.CENTER,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor: Colors.grey[300],
                                                          textColor: Colors.black,
                                                          fontSize: w*0.0388
                                                      ),

                                                      Navigator.of(context).pop(),


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

                        },
                      ),

                      const Divider(
                        thickness: 2,
                        indent: 10,
                        endIndent: 10,
                        color: Color(0xff01579b),
                      ),

                      ListTile(
                        //visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                        dense: true,
                        //contentPadding: EdgeInsets.symmetric( vertical: 0.0),
                        title: Text('Customer Care',style: TextStyle(fontSize: w*0.0437,color: Colors.black,fontFamily: 'Karla')),
                        //subtitle: Text(snapshot.data["RFID"],style: TextStyle(fontSize: w*0.0388,color: Colors.black,fontFamily: 'Karla')),

                        trailing: Icon(Icons.contact_mail,color:Color(0xff01579b),size: w*0.0829,),

                        onTap: ()
                        {


                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>CustCarePage()),
                          );
                        },
                      ),


                      const Divider(
                        thickness: 2,
                        indent: 10,
                        endIndent: 10,
                        color: Color(0xff01579b),
                      ),



                      ListTile(
                        //visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                        dense: true,
                        title: Text('Disclaimer',style: TextStyle(fontSize: w*0.0437,color: Colors.black,fontFamily: 'Karla')),
                       // subtitle: Text(snapshot.data["age"].toString(),style: TextStyle(fontSize: w*0.03645,color: Colors.black,fontFamily: 'Karla')),

                        trailing: Icon(Icons.security,color:Color(0xff01579b),size: w*0.0829,),

                        onTap: _launchDisclaimer,
                      ),

                      const Divider(
                        thickness: 2,
                        indent: 10,
                        endIndent: 10,
                        color: Color(0xff01579b),
                      ),






                      ListTile(
                        //visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                        dense: true,
                        title: Text('Privacy Policy',style: TextStyle(fontSize: w*0.0437,color: Colors.black,fontFamily: 'Karla')),
                       // subtitle: Text(snapshot.data["height"].toString()+"cm",style: TextStyle(fontSize: w*0.03645,color: Colors.black,fontFamily: 'Karla')),
                        trailing: Icon(Icons.privacy_tip,color:Color(0xff01579b),size:w*0.0829,),

                        onTap: _launchPrivacy,
                      ),




                      const Divider(
                        thickness: 2,
                        indent: 10,
                        endIndent: 10,
                        color: Color(0xff01579b),
                      ),


                      ListTile(
                        //visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                        dense: true,
                        title: Text('Logout',style: TextStyle(fontSize: w*0.0437,color: Colors.black,fontFamily: 'Karla')),

                        trailing: Icon(Icons.logout,color:Colors.black,size: w*0.0829,),
                        onTap: () {
                          FirebaseAuth.instance.signOut();

                          Navigator.pop(context);

                          Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) =>LoginPage()));
                        },
                      ),

                      const Divider(
                        thickness: 2,
                        indent: 10,
                        endIndent: 10,
                        color: Color(0xff01579b),
                      ),

                    ],
                  ),
                ),
              );
            }


            return Scaffold(

                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          height:h*0.11856, //100
                          width: w*0.2430, //100
                          child: CircularProgressIndicator()
                      ),
                      SizedBox(height: h*0.011856,),

                      Text("Loading",style: TextStyle(fontSize: w*0.0486),)
                    ],),
                )

            );

          }),


      appBar: AppBar(
        title:  Text(_selectedIndex==0?"Add Jobs":_selectedIndex==1?"Home":"History"),
        backgroundColor: Colors.lightBlue[900],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar
        (
        backgroundColor: Colors.lightBlue[900],
        unselectedItemColor: Colors.white,
        selectedIconTheme: IconThemeData(color: Color(0xffE06E50)),
        items: const <BottomNavigationBarItem>[

          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Add Jobs',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),


          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );

  }

  _launchAbout() async {
    const url = "https://docs.google.com/document/d/1tMysd0ZJ-F7bSNyPdZUC7DBYHqMVlf-5DJPUAZjolT4/edit?usp=sharing";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchDisclaimer() async {
    const url = "https://docs.google.com/document/d/1UdjOAGfgW6is-_UXY1g4ayt875ynEvRxqy4oBjYNBWg/edit?usp=sharing";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchPrivacy() async {
    const url = "https://docs.google.com/document/d/1twA46GChr6vZOE5mBmRtPaQP4lsbbRDXa1MxTDG5KGA/edit?usp=sharing";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}
