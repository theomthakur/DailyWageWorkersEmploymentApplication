import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workers_employment/employerScreen.dart';
import 'package:workers_employment/workerScreen.dart';
import 'home.dart';

class LoginPage extends StatefulWidget
{
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
{

  FirebaseAuth auth = FirebaseAuth.instance;

  final numberController = TextEditingController();

  final loginEmailController = TextEditingController();
  final loginPasswordController= TextEditingController();

  final signupEmailController = TextEditingController();
  final signupPhoneNumberController = TextEditingController();
  final signupPasswordController = TextEditingController();
  final signupConfirmPasswordController = TextEditingController();
  final signupNameController = TextEditingController();

  String dropdownValue = 'Blue Collar';

  String _chosenValue;


  @override
  Widget build(BuildContext context)
  {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold
      (
      body: Container(

        decoration: new BoxDecoration(

          //color: Colors.lightBlue[900],

          image: new DecorationImage(
            image: new AssetImage("assets/images/bg_image4.jpg"),
            alignment: Alignment.topLeft,
            fit: BoxFit.cover,

          ),

        ),
        child: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(top: 100),
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Color(0x00000),
                appBar: TabBar(
                  indicatorColor: Colors.white,
                  labelStyle:
                  TextStyle(fontSize: w*0.0729, fontFamily: 'Family Name'),//30
                  unselectedLabelStyle:
                  TextStyle(fontSize: w*0.0486, fontFamily: 'Family Name'),//20
                  tabs: [
                    Tab(text: 'Login'),
                    Tab(text: 'SignUp'),
                  ],
                ),
                body: TabBarView(
                  children: [
                    SingleChildScrollView(
                      child: Column(children:
                      [

                        SizedBox(
                          height: h*0.0592,//50
                        ),



                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 55),
                          child: TextField(
                            controller: loginEmailController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide:
                                BorderSide(width: 1, color: Colors.red),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: h*0.0355,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 55),
                          child: TextField(
                            controller: loginPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: new BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 0.0237,//20
                        ),
                        Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.white, fontSize: w*0.036),
                        ),
                        SizedBox(
                          height: 0.0829*h,
                        ),



                        Builder(
                          builder: (context) => ButtonTheme(
                            minWidth: w*0.56147,
                            height: h*0.06639,
                            child: Opacity(
                              opacity: 0.7,
                              child: RaisedButton(
                                textColor: Colors.black,
                                color: Colors.white,
                                child: Text(
                                  "Login",
                                  style: TextStyle(fontSize: w*0.05833),
                                ),
                                onPressed: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => HomePage()),
                                  // );

                                  if(loginEmailController.text.trim()=='')
                                  {
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Enter your Email'),
                                      ),
                                    );

                                  }
                                  else if(loginPasswordController.text.trim()=='')
                                  {
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Enter your Password'),
                                      ),
                                    );

                                  }

                                  else
                                  {

                                    //String userEmail,userName,phoneNumber;




                                    auth.signInWithEmailAndPassword(
                                        email: loginEmailController.text.trim(), password: loginPasswordController.text.trim())
                                        .then((result)
                                    {

                                      print(result.user.uid+"====================");

                                      FirebaseFirestore.instance.collection("users").doc(result.user.uid).get()
                                      .then((value)
                                      {
                                        if(value.data()["type"]=="worker")
                                          {
                                            Navigator.pushReplacement
                                              (
                                              context,
                                              MaterialPageRoute(builder: (context) => WorkerScreen(user: result.user,name: value.data()["name"],phone: value.data()["phone"],)),
                                            );
                                          }
                                        else
                                          {
                                            Navigator.pushReplacement
                                              (
                                              context,
                                              MaterialPageRoute(builder: (context) => EmpScreen(user: result.user,name: value.data()["name"],phone: value.data()["phone"],)),
                                            );
                                          }
                                      });

                                    }).catchError((err) {
                                      print(err.message);
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Error"),
                                              content: Text(err.message),
                                              actions: [
                                                TextButton(
                                                  child: Text("Ok"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            );
                                          });
                                    });
                                  }
                                },
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 0.0592,
                        ),
                        Text(
                          '------or SignUp with------',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                        SizedBox(
                          height: h*0.0355,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 55),
                          child: Container(
                            height: h*0.0592,
                            width: w*0.1215,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                  new AssetImage("assets/images/google1.jpg"),
                                  fit: BoxFit.cover),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ]),
                    ),


                    SingleChildScrollView(

                      // reverse: true,
                      child: Column(children: [
                        SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 55),
                          child: TextField(
                            controller: signupNameController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: new BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: h*0.0355,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 55),
                          child: TextField(
                            controller: signupPhoneNumberController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter Phone no',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: new BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: h*0.0355,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 55),
                          child: TextField(
                            controller: signupEmailController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: new BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: h*0.0355,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 55),
                          child: TextField(
                            controller: signupPasswordController,
                            obscureText: true,

                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Set a Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: new BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: h*0.0355,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 55),
                          child: TextField(
                            controller: signupConfirmPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Confirm Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: new BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: h*0.0355,
                        ),

                        Container(

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),

                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Theme(

                              data: Theme.of(context).copyWith(
                                canvasColor: Colors.white,
                              ),

                              child: DropdownButton<String>(
                                value: _chosenValue,
                                //elevation: 5,
                                style: TextStyle(color: Colors.black),


                                items: <String>[
                                  'Worker',
                                  'Contractor',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                hint: Text(
                                  "Choose who you are.",
                                  style: TextStyle(

                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,

                                  ),
                                ),
                                onChanged: (String value) {
                                  setState(() {
                                    _chosenValue = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),

                      SizedBox(
                      height: h*0.0355,
                    ),


                        Builder(
                          builder: (context) => ButtonTheme(
                            minWidth: 0.486*w,
                            height: h*0.066,
                            child: Opacity(
                              opacity: 0.7,
                              child: RaisedButton(
                                textColor: Colors.black,
                                color: Colors.white,
                                child: Text(
                                  "Register",
                                  style: TextStyle(fontSize: 24.0),
                                ),
                                onPressed: ()
                                {

                                  if( signupNameController.text.trim()=='')
                                  {

                                    Scaffold.of(context).showSnackBar(SnackBar
                                      (
                                      content: Text('Enter your name'),
                                      duration: Duration(seconds: 3),
                                    ));


                                  }

                                  else if(signupPhoneNumberController.text.trim()=='')
                                  {
                                    Scaffold.of(context).showSnackBar(SnackBar
                                      (
                                      content: Text('Enter your Phone Number'),
                                      duration: Duration(seconds: 3),
                                    ));

                                  }
                                  else if(signupEmailController.text.trim()=='')
                                  {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text('Enter your Email'),
                                      duration: Duration(seconds: 3),
                                    ));

                                  }

                                  else if(signupPasswordController.text.trim()=='')
                                  {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text('Enter your Password'),
                                      duration: Duration(seconds: 3),
                                    ));

                                  }

                                  else if(signupConfirmPasswordController.text.trim()=='')
                                  {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text('Confirm your password'),
                                      duration: Duration(seconds: 3),
                                    ));

                                  }

                                  else if(signupPasswordController.text != signupConfirmPasswordController.text)
                                  {
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Passwords do not match'),
                                      ),
                                    );
                                  }
                                  else if(_chosenValue==null)
                                    {
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text('Please Choose your requirement'),
                                        duration: Duration(seconds: 3),
                                      ));
                                    }

                                  else
                                  {

                                    print(_chosenValue);

                                    auth.createUserWithEmailAndPassword(
                                        email: signupEmailController.text.trim(), password: signupConfirmPasswordController.text.trim())
                                        .then((result)
                                    {

                                      FirebaseFirestore.instance.collection("users").doc(result.user.uid).set(
                                          {
                                            "email": signupEmailController.text.trim(),
                                            "name": signupNameController.text.trim(),
                                            "phone": signupPhoneNumberController.text.trim(),
                                            "type":_chosenValue=="Blue Collar"?"worker":"employer"
                                          }).then((res)
                                      {

                                        if(_chosenValue=="Blue Collar")
                                          {
                                            Navigator.pushReplacement
                                              (
                                              context,
                                              MaterialPageRoute(builder: (context) => WorkerScreen(user: result.user,name:signupNameController.text.trim(),phone: signupPhoneNumberController.text.trim() ,)),
                                            );
                                          }
                                          else
                                          {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(builder: (context) => EmpScreen(user:result.user ,name: signupNameController.text.trim(),phone: signupPhoneNumberController.text.trim(),)),
                                            );
                                          }


                                      }).catchError((err2)
                                      {
                                        print(err2.toString());
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Error"),
                                                content: Text(err2.message),
                                                actions: [
                                                  FlatButton(
                                                    child: Text("Ok"),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                  )
                                                ],
                                              );
                                            });

                                      });
                                    }).catchError((err) {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Error"),
                                              content: Text(err.message),
                                              actions: [
                                                FlatButton(
                                                  child: Text("Ok"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            );
                                          });
                                    });
                                  }

                                },
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),



    );

  }
}
