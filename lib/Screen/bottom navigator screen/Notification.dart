import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapittek/Screen/bottom%20navigator%20screen/Profile/profile.dart';
import 'package:tapittek/Utils/Appbar.dart';
import 'package:http/http.dart' as http;


import '../../Const/image_const.dart';
import '../../Model/GetUserPost.dart';
import '../../Utils/app_preferences.dart';
import '../LoginFlow/SignIn.dart';
import '../drawernavigator/device_compatibility.dart';
import 'homepage.dart';

class Notificationscreen extends StatefulWidget {
  const Notificationscreen({Key? key}) : super(key: key);

  @override
  State<Notificationscreen> createState() => _NotificationscreenState();
}

class _NotificationscreenState extends State<Notificationscreen> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      appBar: AppBar(
        actions: [

          PopupMenuButton(
            // add icon, by default "3 dot" icon
            // icon: Icon(Icons.book)
              itemBuilder: (context){
                return [
                  /*    PopupMenuItem<int>(
                    value:0,
                    child: Text("My account"),
                  ),
                  PopupMenuItem<int>(
                    value: 1,
                    child: Text("Settings"),
                  ),

                  PopupMenuItem<int>(
                    value: 2,
                    child: Text("Logout"),
                  ),*/
                ];
              },
              onSelected:(value){
                if(value == 0){
                  print("My account menu is selected.");
                }else if(value == 1){
                  print("Settings menu is selected.");
                }else if(value == 2){
                  print("Logout menu is selected.");
                }
              }
          ),
        ],
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Padding(
          padding: const EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
          child: Row(children: [
            Text("Tapittek",style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.w700,fontSize:35,color:Color(
                0xfff8d026)),),

          ],),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //appbar(),
          Expanded(child:
          SingleChildScrollView(child:
          Column(
            children: [
              list(),
            ],
          ))),

        ],),

      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30.0,
                                    backgroundColor: Colors.grey,
                                    child:photoUrl?
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.network(snapshot.data!.posts![0].userDetails![0].profileImage.toString(), width: 60,
                                        height: 60,fit: BoxFit.fill,),
                                    )
                                        :
                                    InkWell(
                                      //onTap: imagePickerOption,
                                      child: Image.asset(
                                        ImageConst().UPLOAD_IMAGES,
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10,),

                                  Center(child: photoUrl?
                                  Text( snapshot.data!.posts![0].userDetails![0].name ?? "",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),)
                                      :Text("Name"),
                                  ),
                                ],
                              ),

                            ],
                          );
                        }
                        else{
                          return Center(child: CircularProgressIndicator());
                        }

                      }
                  ),
                  Divider(thickness: 1.5,),
                  SizedBox(height: 25,),
                  InkWell(
                    onTap: (){
                      // Navigator.push(context, MaterialPageRoute(
                      //     builder: (context) => Notificationscreen()));
                    },
                    child: Row(children: [
                      Icon(Icons.supervised_user_circle,size: 28,),
                      SizedBox(width: 10,),
                      Text("Complete Profile",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                    ],),
                  ),

                ],),
            ),
            ListTile(
              title:
              InkWell(
                onTap: (){
                  // Navigator.push(context, MaterialPageRoute(
                  //     builder: (context) => Notificationscreen()));
                },
                child: Row(children: [
                  Icon(Icons.supervised_user_circle,size: 28,),
                  SizedBox(width: 10,),
                  Text("My connection",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                ],),
              ),
            ),

            ListTile(
              title:
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => DeviceCompatibility()));
                },
                child: Row(children: [
                  Icon(Icons.phone_android,size: 28,),
                  SizedBox(width: 10,),
                  Text("Device compatibility",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                ],),
              ),
            ),
            ListTile(
              title:
              InkWell(
                onTap: (){
                  // Navigator.push(context, MaterialPageRoute(
                  //     builder: (context) => Notificationscreen()));
                },
                child: Row(children: [
                  Icon(Icons.help_outline_outlined,size: 28,),
                  SizedBox(width: 10,),
                  Text("Help",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                ],),
              ),
            ),
            ListTile(
              title:
              InkWell(
                onTap: (){
                  // Navigator.push(context, MaterialPageRoute(
                  //     builder: (context) => Notificationscreen()));
                },
                child: Row(children: [
                  Icon(Icons.settings,size: 28,),
                  SizedBox(width: 10,),
                  Text("Setting",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                ],),
              ),
            ),

            ListTile(
              title:
              InkWell(
                onTap: () async {
                  SharedPreferences pref = await SharedPreferences.getInstance();
                  pref.remove("email");
                  Navigator.pop(context);
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => signinscreen()));
                },
                child: Row(children: [
                  Icon(Icons.logout,size: 28,),
                  SizedBox(width: 10,),
                  Text("Logout",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                ],),
              ),
            ),
          ],
        ),
      ),


    ));
  }
}

Widget list(){
  return
    Container(
    padding: EdgeInsets.only(top: 23,left: 16,right: 16),
    child: ListView.separated(
      separatorBuilder: (context, index) {
        return Divider(thickness: 1.5,);
      },
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context , int index){
        return Row(
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundImage:
              NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZ1brMuYccWnlB6_i6TvXJmjHyoksaNNP3pHx4C9qMpg&s"),
              backgroundColor: Colors.transparent,
            ),
            SizedBox(width: 10,),
            Expanded(
                flex: 1,
                child: Text("Nidhi Aggarwal\nmore",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w700),)),
            Text("21/03  /2023"),

            /* SizedBox(width: 10,),
          Row(
             //crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text("Nidhi Aggarwal",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w700),),
              Text("More"),

            ],)*/
          ],);

      },
      itemCount: 54,
    ),
  );
}

Widget appbar() {
  return Padding(
    padding: const EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
    child: Row(children: [
      Text("Tapittek",style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.w700,fontSize:35,color:Color(
          0xfff8d026)),),

    ],),
  );
}

Future<GetUserPost?> createAlbum() async {
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