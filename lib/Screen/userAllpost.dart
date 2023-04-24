import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapittek/Utils/configuration.dart';
import '../../Model/GetUserPost.dart';
import 'package:http/http.dart' as http;

import '../Utils/app_preferences.dart';



class userposts extends StatefulWidget {
  const userposts({Key? key}) : super(key: key);

  @override
  State<userposts> createState() => _userpostsState();
}

class _userpostsState extends State<userposts> {

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


    return SafeArea(child: Scaffold(
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
            Text("Tapittek",style: TextStyle(fontWeight: FontWeight.w700,fontSize:35,color:Color(
                0xfff8d026)),),

          ],),
        ),
      ),

      body: FutureBuilder<GetUserPost?>(
          future:  createAlbum(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
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
                                  return
                                    Column(
                                    children: [
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
                                                // Navigator.push(context, MaterialPageRoute(
                                                //     builder: (context) => Profile()));
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
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
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

                                  ],
                                  );
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


    )
    );

  }
}


//https://test.pearl-developer.com/mdk/public/api/get-all-posts


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



