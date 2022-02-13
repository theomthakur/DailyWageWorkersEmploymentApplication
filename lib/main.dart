import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workers_employment/workerScreen.dart';

import 'employerScreen.dart';
import 'home.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> 
{

  FirebaseAuth auth = FirebaseAuth.instance;
  User currentUser;
  String userType;
  String name;
  String phone;
  
  

  final numberController = TextEditingController();

  final loginEmailController = TextEditingController();
  final loginPasswordController= TextEditingController();

  final signupEmailController = TextEditingController();
  final signupPhoneNumberController = TextEditingController();
  final signupPasswordController = TextEditingController();
  final signupConfirmPasswordController = TextEditingController();
  final signupNameController = TextEditingController();


  // @override
  // void initState() {
  //   super.initState();
  //   getCurrentUser();
  // }

  @override
  Future<void> initState()  {
    super.initState();
    getCurrentUser();

    Timer
      (
        Duration(seconds: 3),()
    {
      if(currentUser!=null)
      {
        print("Null-user //////// Timer ");
        //Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) =>LoginPage()));

        if(userType=="worker")
          {
            Navigator.pushReplacement
              (
              context,
              MaterialPageRoute(builder: (context) => WorkerScreen(user: currentUser,name: name,phone: phone)),
            );
          }
        else
          {
            Navigator.pushReplacement
              (
              context,
              MaterialPageRoute(builder: (context) => EmpScreen(user: currentUser,name: name,phone: phone,)),
            );
          }

      }
      else
        {
          Navigator.pushReplacement
            (
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        }

    }
    );
  }


  void getCurrentUser() async
  {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User user)
    {
      currentUser=user;

      if(currentUser!=null)
      {
        FirebaseFirestore.instance.collection("users").doc(currentUser.uid)
            .get().then((value)
        {
          userType=value.data()["type"];
          name=value.data()["name"];
          phone=value.data()["phone"];
        });
      }

    });




  }


  @override
  Widget build(BuildContext context) 
  {

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
          child:Container(
            width: 300,
            height: 100,
            child: Center(
                child: Image.asset("assets/images/home.jpg")
            ),
          )
      ),
    );
  }
}
