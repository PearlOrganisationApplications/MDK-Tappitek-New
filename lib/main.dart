import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapittek/Screen/bottom%20navigator%20screen/homepage.dart';
import 'package:tapittek/Utils/app_preferences.dart';
import 'Screen/LoginFlow/SignIn.dart';
import 'Screen/homescreen.dart';
import 'View_Model/my_friend_list.dart';
import 'Viewmodel/socialmedialappviewmodel.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences.init();
  SharedPreferences prefs =await SharedPreferences.getInstance();
  var email=prefs.getString("email");
  print(email);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: email==null?signinscreen():HomeScreen(),
  ));

  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => SocialMediaappViewModel()),
      ChangeNotifierProvider(create: (_) => YourFriendList()),
    ],
    child:  MyApp(),
  );
}


/*Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

 // await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SocialMediaappViewModel()),
      ],
      child:  MyApp(),
    ),
  );
}*/

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                    signinscreen()
                    //signupscreen()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
      child: Image.asset("assets/logo.jpg"),
    );
  }
}

