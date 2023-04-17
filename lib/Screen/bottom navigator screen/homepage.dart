import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapittek/Utils/configuration.dart';
import '../../Const/image_const.dart';
import '../../Model/GetUserPost.dart';
import '../../Model/alluserpostModel.dart';
import '../../Utils/Api_collection.dart';
import '../../Utils/app_preferences.dart';
import '../LoginFlow/SignIn.dart';
import '../drawernavigator/device_compatibility.dart';
import 'Notification.dart';
import 'package:http/http.dart' as http;

import 'Profile/profile.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}
// Future<Alluserpost?> fetchAlbumn() async {
//
//   var headers = {
//     'Authorization': 'Bearer 166|69cN7AOpLMCZODnyRIvaoYZufARtWWzm1BSdcIWQ'
//   };
//   var request = http.MultipartRequest('POST', Uri.parse('https://test.pearl-developer.com/mdk/public/api/get-all-posts'));
//
//   request.headers.addAll(headers);
//
//   http.StreamedResponse response = await request.send();
//
//   if (response.statusCode == 200) {
//     print(await response.stream.bytesToString());
//   }
//   else {
//     print(response.reasonPhrase);
//   }
//
// }


class _homepageState extends State<homepage> {






  Future<bool> _willPopCallback() async {
    exit(0);
    // await showDialog or Show add banners or whatever
    // then
    return true; // return true if the route to be popped
  }
  @override
  Widget build(BuildContext context) {

    bool _isTap = false;
    Color _favIconColor = Colors.grey;


    return WillPopScope(
      onWillPop: _willPopCallback,

      child: SafeArea(child: Scaffold(
        appBar: AppBar(
          actions: [

            PopupMenuButton(
              // add icon, by default "3 dot" icon
              // icon: Icon(Icons.book)
                itemBuilder: (context){
                  return [
                    /*PopupMenuItem<int>(
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

        body: FutureBuilder<GetUserPost?>(
            future:  createAlbum(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {

                return
                  Column(
                  children: [
                    //Commonappbar(),

                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              // listview(),

                              Container(
                                //padding: EdgeInsets.only(top: 23),
                                child: ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return Divider(thickness: 1.5,);
                                  },
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, int index) {
                                    return Column(children: [
                                      // Text("Govind"),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 16),
                                            child: Row(children: [

                                              InkWell(
                                            onTap: ()
                                    {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => Profile()));
                                    },
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.grey,
                                                  backgroundImage:snapshot.data!.posts![index].userDetails![0].profileImage.toString().isNotEmpty
                                                      ? NetworkImage(snapshot.data!.posts![index].userDetails![0].profileImage.toString())
                                                      : null,
                                                ),
                                              ),

                                              SizedBox(width: 10,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(snapshot.data!.posts![index].userDetails![0].name.toString()),

                                                  //Text("Deven mestry is with Mahesh\nJoshi."),

                                                ],),

                                            ],),
                                          ),

                                          SizedBox(height: 10,),
                                          Padding(
                                            padding:  EdgeInsets.only(
                                                left: 16, bottom: 5),
                                            child: Text(snapshot.data!.posts![index].text.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14),),

                                          ),

                                          //SvgPicture.asset("assets/car.svg"),
                                          //Image.asset("assets/picture.jpg"),
                                          SizedBox(child:
                                          Image.network(
                                            snapshot.data!.posts![index].postImage.toString(),
                                            fit: BoxFit.fill,)
                                            , width: double.infinity,
                                            height: 400,
                                          ),

                                          //NetworkImage(snapshot.data!.posts![index].PROFILEIMAGE+image.toString()),


                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [


                                                    InkWell(

                                                      onTap: () {
                                                        print("okkkk");
                                                        {
                                                          setState(() {
                                                            _isTap = false;
                                                          });
                                                        }
                                                      },
                                                      child: Icon(Icons
                                                          .thumb_up_alt_rounded,
                                                          color: (_isTap) ? Colors
                                                              .yellow : Colors
                                                              .deepOrange),

                                                    ),
                                                    SizedBox(width: 30,),
                                                    Icon(Icons.comment),


                                                    SizedBox(width: 30,),
                                                    // Image.asset("assets/share.jpg",fit:BoxFit.fill,),
                                                  ],),

                                                SizedBox(height: 16,),

                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Liked by Sachin Kamble and 155 others ",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .w600,
                                                          fontSize: 11),),

                                                    Text("4 comments",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .w400,
                                                          fontSize: 11),),

                                                  ],)
                                              ],
                                            ),
                                          )

                                        ],
                                      ),

                                    ],);
                                  },
                                  itemCount: snapshot.data!.posts!.length,
                                  //itemCount: 10,

                                ),

                              ),

                            ],
                          ),
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
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Notificationscreen()));
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
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Notificationscreen()));
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
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Notificationscreen()));
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
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Notificationscreen()));
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


      )
      ),
    );

  }
}




/*
Widget listview(){
  Color _favIconColor = Colors.grey;
  return
    Container(
    //padding: EdgeInsets.only(top: 23),
    child: ListView.separated(
      separatorBuilder: (context, index) {
        return Divider(thickness: 1.5,);
      },
      shrinkWrap: true,
      physics:  NeverScrollableScrollPhysics(),
      itemBuilder: (context , int index){
        return Column(children: [
          // Text("Govind"),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16,right: 16),
                child: Row(children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage:
                    NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQThNbRv-cwCjO9vnelKnZqbxy4qQcl3Xdcrhf4C8xHsg&usqp=CAU&ec=48600112"),
                    backgroundColor: Colors.transparent,
                  ),
                  */
/* Container(
                    child:
                   // SvgPicture.asset("assets/ell.svg"),
                   Image.asset("assets/dp.jpg",fit:BoxFit.fill,),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.red,),
                    height: 70,width: 70,),*//*

                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Deven mestry is with Mahesh\nJoshi."),
                   */
/*   Row(children: [
                        Text("1 h .  Mumbai, Maharastra .",style: TextStyle(color: Color(0xff999999,),fontSize: 14,fontWeight: FontWeight.w400),),
                        Icon(Icons.people,color: Color(0xff999999),),
                      ],)*//*


                    ],),

                ],),

              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 16,bottom: 5),
                child: Text("Old is Gold..!! ",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14),),

              ),
              //SvgPicture.asset("assets/car.svg"),
              Image.asset("assets/picture.jpg"),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                      InkWell(
                          onTap: (){
                            setState(() {
                              if(_favIconColor == Colors.grey){
                                _favIconColor = Colors.red;
                              }else{
                                _favIconColor = Colors.grey;
                              }
                            });
                          },
                          child: Icon(Icons.thumb_up_alt_rounded)

                      ),
                      SizedBox(width: 30,),
                      Icon(Icons.comment),


                      SizedBox(width: 30,),
                     // Image.asset("assets/share.jpg",fit:BoxFit.fill,),
                    ],),

                    SizedBox(height: 16,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Liked by Sachin Kamble and 155 others ",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 11),),

                        Text("4 comments",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 11),),

                      ],)
                  ],
                ),
              )

            ],
          ),

        ],);

      },
      itemCount: 5,

    ),

  );
}
*/


//https://test.pearl-developer.com/mdk/public/api/get-all-posts


Future<String?> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

Future<GetUserPost?> createAlbum( ) async {
  var token;
  getToken();
  var headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };
  final response = await http.post(
     Uri.parse('https://test.pearl-developer.com/mdk/public/api/get-all-posts'),
    //Uri.parse('https://test.pearl-developer.com/mdk/public/api/get-user-posts'),
    headers: headers,

  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    return GetUserPost.fromJson(jsonDecode(response.body));
  }
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








