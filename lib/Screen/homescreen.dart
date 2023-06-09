import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../Const/image_const.dart';
import '../Model/GetUserPost.dart';
import '../Utils/app_preferences.dart';
import 'bottom navigator screen/Notification.dart';
import 'bottom navigator screen/homepage.dart';
import 'bottom navigator screen/Profile/profile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'drawernavigator/device_compatibility.dart';
import 'friend/frienslist.dart';
import 'package:http/http.dart' as http;
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
            (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }



  final ScrollController _homeController = ScrollController();

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[

    homepage(),
    homepage(),
    friendslist(),
    Notificationscreen(),
    Profile(),
    // socialmedialink(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {

    Future<bool> _willPopCallback() async {
      exit(0);
      // await showDialog or Show add banners or whatever
      // then
      return true; // return true if the route to be popped
    }
    return

      WillPopScope(
        // onWillPop: _willPopCallback,

        onWillPop: () async {
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title:  Text('Do you want to exit ?'),
                //actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: [

                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child:  Text('No'),
                  ),

                  TextButton(
                    onPressed: () {
                      _willPopCallback();
                      // Navigator.pop(context, true);
                    },
                    child:  Text('Yes'),
                  ),
                ],
              );
            },
          );
          return shouldPop!;
        },
        child: SafeArea(child:  Scaffold(

          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),


          bottomNavigationBar: BottomNavigationBar(
              items:  <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),

                BottomNavigationBarItem(
                  icon: Icon(Icons.qr_code_scanner),
                  label: 'Scanner',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people_alt_sharp),
                  label: 'Friends',
                ),
                /*    BottomNavigationBarItem(
              icon: Icon(Icons.recycling_rounded),
              label: 'Data',
            ),*/
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  label: 'Notification',
                ),
                BottomNavigationBarItem(
                   icon:
                   FutureBuilder<GetUserPost?>(
                       future:  userprofile(),
                       builder: (context, snapshot) {

                         if (snapshot.hasData) {
                           late bool photoUrl;
                           try {
                             int a = snapshot.data!.posts!.isEmpty ? 0: 10 ?? 0;
                             photoUrl = a==0? false:true;
                           }catch (e){
                           }
                           print(photoUrl);
                           return Column(
                             children: [
                               //Commonappbar(),
                               CircleAvatar(
                                 radius: 18.0,
                                 backgroundColor: Colors.green,
                                 child:photoUrl?
                                 ClipRRect(
                                   borderRadius: BorderRadius.circular(100),
                                   child: Image.network(snapshot.data!.posts![0].userDetails![0].profileImage.toString(), width: 50,
                                     height: 50,fit: BoxFit.fill,),
                                 )
                                     :
                                 InkWell(
                                   //onTap: imagePickerOption,
                                   child: Image.asset(
                                     ImageConst().UPLOAD_IMAGES,
                                     width: 33,
                                     height: 33,
                                     fit: BoxFit.cover,
                                   ),
                                 ),
                               ),

                             ],
                           );
                         }
                         else{
                           return Center(child: CircularProgressIndicator());
                         }

                       }
                   ),

                  // CircleAvatar(
                  //   radius: 20.0,
                  //   backgroundImage:
                  //   NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQThNbRv-cwCjO9vnelKnZqbxy4qQcl3Xdcrhf4C8xHsg&usqp=CAU&ec=48600112"),
                  //   backgroundColor: Colors.transparent,
                  // ),
                  label: 'Profile',
                ),
              ],

              currentIndex: _selectedIndex,
              selectedItemColor: Colors.amber[800],
              unselectedItemColor: Colors.black,
              onTap: (int index) {
                switch (index) {
                  case 0:
                  // only scroll to top when current index is selected.
                    if (_selectedIndex == index) {
                      _homeController.animateTo(
                        0.0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeOut,
                      );
                    }
                    break;
                  case 1:
                    showSettingDialog(context);
                    break;
                }
                setState(
                      () {
                    _selectedIndex = index;
                  },
                );
              }

          ),
        )),
      );
  }
  showDialogBox() => showCupertinoDialog<String>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('No Connection'),
      content: const Text('Please check your internet connectivity'),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            Navigator.pop(context, 'Cancel');
            setState(() => isAlertSet = false);
            isDeviceConnected =
            await InternetConnectionChecker().hasConnection;
            if (!isDeviceConnected && isAlertSet == false) {
              showDialogBox();
              setState(() => isAlertSet = true);
            }
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );

  showSettingDialog(BuildContext context,) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return showModalBottomSheet<void>(
      backgroundColor: const Color(0xfff1f1f1),
      // context and builder are
      // required properties in this widget+
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0)),
      ),
      context: context,
      builder: (context1) {
        // we set up a container inside which
        // we create center column and display text
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(left: 30,),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //
            //     SizedBox(
            //       width: 100,
            //       child: Center(
            //         child: Icon(
            //         Icons.near_me_outlined,
            //         size: 40,
            //         color: Colors.black, //<-- SEE HERE
            //   ),
            //       ),
            //     ),
            //       Icon(
            //         Icons.arrow_drop_down,
            //         size: 40,
            //         color: Colors.black, //<-- SEE HERE
            //       ),
            //
            //     ],
            //   ),
            // ),

            Text(
              "Pick a direct link ",
              style: GoogleFonts.montserrat(
                  fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Container(
              width: width * 0.7,
              height: height * 0.06,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(30)),
            ),
            Text(
              "Whe you tap someone phone \n this link will be opened instead of your full profile ",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(),
            ),

          ],
        );
      },
    );
  }



/*  void showModal(BuildContext context) {

    showModalBottomSheet<void>(shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only( topRight: Radius.circular(14),topLeft: Radius.circular(14)),
    ),

      backgroundColor: Color(0xffD9D9D9),
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 300,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  <Widget>[
                Container(
                  child: Image.asset("assets/facebook.jpg",fit: BoxFit.fill,),
                  decoration: BoxDecoration(
                      color: Color(0xffFEE572),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  //color: Colors.red,
                  height: 46,width: 46,
                ),
                SizedBox(height: 10,),
                Text('Facebook',style: TextStyle(fontWeight:FontWeight.w400,fontSize: 18),),
                SizedBox(height: 13,),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                        filled: true,
                        fillColor: Colors.white
                      //hintText: 'Write something about',
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 35,right: 35),
                  child: SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all( Color(0xff000000)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  // side: BorderSide(color: Colors.red)
                                )
                            )
                        ),
                        onPressed: (){
                          //Navigator.push(context, MaterialPageRoute(builder: (context) =>  HomeScreen()));
                        },
                        child:  Text("Save",style: TextStyle(color: Colors.white),)
                    ),
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );





    *//* showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('Example Dialog'),
        actions: <TextButton>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          )
        ],
      ),
    );*//*
  }*/
}


Future<GetUserPost?> userprofile() async {
  var headers = {
    'Authorization': 'Bearer '+"${AppPreferences.getToken()!}"
  };
  final response = await http.post(
    Uri.parse('https://test.pearl-developer.com/mdk/public/api/get-user-posts'),
    headers: headers,

  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    return GetUserPost.fromJson(jsonDecode(response.body));
  }
}