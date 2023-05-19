import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapittek/Screen/bottom%20navigator%20screen/Profile/allsocialmedialink.dart';
import 'package:tapittek/Screen/friend/suggestionfriends.dart';
import 'package:http/http.dart' as http;

import '../../Const/image_const.dart';
import '../../Model/Request_List.dart';
import '../../Model/UserlistModel.dart';
import '../../Utils/app_preferences.dart';
import 'Allfriendrequests.dart';
import 'Yourfriend.dart';
class friendslist extends StatefulWidget {
  const friendslist({Key? key}) : super(key: key);

  @override
  State<friendslist> createState() => _friendslistState();
}

class _friendslistState extends State<friendslist> {
  bool isEnabled = false;
  bool onTapping = false;
  String editProfile = "Edit Profile";

  String? Email;
  void getEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? email = pref.getString("email");
    setState(() {
      Email = email;
    });
    print("amit emailllllllllllll"+"${Email}");

  }

  @override
  void initState() {
    getEmail();
    super.initState();
    // post = fetchPost();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child:
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Friends",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),),
              Row(
                //crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Text("Nidhi",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w700),),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 40,
                      //width: double.infinity,
                      child:
                      ElevatedButton(

                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.lightBlue),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(19.0),
                                    // side: BorderSide(color: Colors.red)
                                  )
                              )
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => AddnewFriend()));
                          },
                          child: Text("Suggestions",
                            style: TextStyle(color: Colors.black),)
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 40,
                      width: double.infinity,
                      child:
                      ElevatedButton(

                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.grey),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(19.0),
                                    // side: BorderSide(color: Colors.red)
                                  )
                              )
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => Yourfriend()));
                          },
                          child: Text("Your Friends",
                            style: TextStyle(color: Colors.black),)
                      ),
                    ),
                  ),

                ],),
              SizedBox(height: 7,),
              Divider(thickness: 2,),


              FutureBuilder<List<Friends>>(
                  future: request_list(Email),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {

                      return
                        Container(
                          padding: EdgeInsets.only(top: 16,),
                          child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 14,);

                              //Divider(thickness: 1.5,);
                            },
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, int index) {
                              return Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    radius: 40.0,
                                    backgroundImage:
                                    NetworkImage(snapshot.data![index].profileImage.toString()
                                    ),
                                    //"https://images.unsplash.com/photo-1618641986557-1ecd230959aa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80"),
                                    backgroundColor: Colors.grey,
                                  ),

                                  SizedBox(width: 10,),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(snapshot.data![index].name??"", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                                        // Text("Govind Kumar", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),

                                        Row(
                                          //crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            //Text("Nidhi",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w700),),
                                            Expanded(
                                              flex: 1,
                                              child: SizedBox(
                                                height: 40,
                                                width: double.infinity,
                                                child:
                                                ElevatedButton(
                                                    style: ButtonStyle(
                                                        backgroundColor: MaterialStateProperty
                                                            .all(Colors.greenAccent),
                                                        shape: MaterialStateProperty
                                                            .all<
                                                            RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .circular(12.0),
                                                              // side: BorderSide(color: Colors.red)
                                                            )
                                                        )
                                                    ),
                                                    onPressed: () {
                                                      response(
                                                        snapshot.data![index].myRequestId.toString(),
                                                       // 17.toString(),
                                                          Email,
                                                        1.toString(),
                                                      );
                                                      Fluttertoast.showToast(msg: "Request accepted");


                                                    },
                                                    child: Text("Confirm",
                                                      style: TextStyle(
                                                          color: Colors.black),)
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            //Spacer(),
                                            Expanded(
                                              flex: 1,
                                              child: SizedBox(
                                                height: 40,
                                                width: double.infinity,
                                                child:
                                                ElevatedButton(
                                                    style: ButtonStyle(
                                                        backgroundColor: MaterialStateProperty
                                                            .all(Color(0xffed5555)),
                                                        shape: MaterialStateProperty
                                                            .all<
                                                            RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .circular(12.0),
                                                              // side: BorderSide(color: Colors.red)
                                                            )
                                                        )
                                                    ),
                                                    onPressed: () {
                                                      response(
                                                        snapshot.data![index].myRequestId.toString(),
                                                        // 17.toString(),
                                                          Email,
                                                          0.toString(),
                                                      );
                                                      Fluttertoast.showToast(msg: "Request deleted");
                                                    },
                                                    child: Text("Delete",
                                                      style: TextStyle(
                                                          color: Colors.black),)
                                                ),
                                              ),
                                            ),
                                          ],),
                                      ],
                                    ),
                                  ),
                                  //SizedBox(height: 5,),

                                ],);
                            },
                            //itemCount: 4,
                            itemCount: snapshot.data!.length,
                          ),
                        );


                    }
                    else {
                      return Center(child: CircularProgressIndicator(),);
                    }
                  }
              ),





              SizedBox(height: 16,),
              SizedBox(
                height: 40,
                width: double.infinity,
                child:
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.grey),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              // side: BorderSide(color: Colors.red)
                            )
                        )
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (
                          context) => AllFriendrequest()));
                    },
                    child: Text(
                      "See All", style: TextStyle(color: Colors.black),)
                ),
              ),
              SizedBox(height: 10,),
              Divider(thickness: 1,),
              SizedBox(height: 10,),
              Text("People You May Know",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500),),


              FutureBuilder<List<Users>>(
                  future: userlist(Email),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {

                      return Container(
                        padding: EdgeInsets.only(top: 23, bottom: 20),
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 14,);

                            //Divider(thickness: 1.5,);
                          },
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, int index) {
                            return
                              Row(
                                children: [
                                  // Text(snapshot.data![index].name.toString()),
                                  //Text(snapshot.data!.users![index].name ??""),

                                  // CircleAvatar(
                                  //   radius: 30.0,
                                  //   backgroundColor: Colors.grey,
                                  //   child:
                                  //   Image.network(snapshot.data![index].profileImage.toString(), width: 60,
                                  //     height: 60,fit: BoxFit.fill,)
                                  //   //     :
                                  //   // ClipRRect(
                                  //   //   borderRadius: BorderRadius.circular(100),
                                  //   //   child: Icon(Icons.ac_unit),
                                  //   //   //Image.asset("assets/dp.jpg"),                                      )
                                  //   // ),
                                  // ),


                                  CircleAvatar(
                                    radius: 40.0,
                                    backgroundImage: NetworkImage(snapshot.data![index].profileImage ?? ""
                                       // "https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg"
                                    ),
                                    backgroundColor: Colors.grey,
                                  ),

                                  SizedBox(width: 10,),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(
                                          snapshot.data![index].name ?? "",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                        //Text(list[0].name.toString()),
                                        // Text("Govind Kumar",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),

                                        Row(
                                          //crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            //Text("Nidhi",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w700),),
                                            Expanded(
                                              flex: 1,
                                              child: SizedBox(
                                                height: 40,
                                                width: double.infinity,
                                                child:
                                                ElevatedButton(
                                                    style: ButtonStyle(
                                                        backgroundColor: MaterialStateProperty
                                                            .all(Colors
                                                            .greenAccent),
                                                        shape: MaterialStateProperty
                                                            .all<
                                                            RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .circular(
                                                                  12.0),
                                                              // side: BorderSide(color: Colors.red)
                                                            )
                                                        )
                                                    ),
                                                    onPressed: () {

                                                      sendfriendrequest(
                                                          snapshot.data![index].id.toString(),
                                                          Email,
                                                      );
                                                      Fluttertoast.showToast(msg: "Request Sending");

                                                    },
                                                    child: Text("Add Friend",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black),)
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            //Spacer(),

                                            Expanded(
                                              flex: 1,
                                              child: SizedBox(
                                                height: 40,
                                                width: double.infinity,
                                                child:
                                                ElevatedButton(
                                                    style: ButtonStyle(
                                                        backgroundColor: MaterialStateProperty
                                                            .all(Color(
                                                            0xffed5555)),
                                                        shape: MaterialStateProperty
                                                            .all<
                                                            RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .circular(
                                                                  12.0),
                                                              // side: BorderSide(color: Colors.red)
                                                            )
                                                        )
                                                    ),
                                                    onPressed: () {},
                                                    child: Text(
                                                      "Remove",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black),)
                                                ),
                                              ),
                                            ),
                                          ],),
                                      ],
                                    ),
                                  ),

                                ],);
                          },
                          // itemCount: list.length,
                          itemCount: snapshot.data!.length,
                        ),
                      );
                    }
                    else {
                      return Center(child: CircularProgressIndicator(),);
                    }
                  }
              ),


            ],),

        ),
      ),),);
  }





// Future<Userlist?> allfriendlist()async{
//   try{
//
//     var headers = {
//       'Authorization': 'Bearer 366|SfA22ZUvX4Mh6yfhHZdzy9RrityeP1hLc6rpzIHJ'
//     };
//     var response = await http.post(Uri.parse('https://test.pearl-developer.com/mdk/public/api/user-list'), body: {
//       'email': 'deepak@gmail.com'
//
//     });
//
//
//     response.headers.addAll(headers);
//
//     // http.StreamedResponse response = await request.send();
//     var data = response.body;
//
//     if (response.statusCode == 200) {
//       print("govind"+data);
//       // print("---------user List--------"+await response.stream.bytesToString());
//     }
//     else {
//       print("---------else print------------"+"${response.reasonPhrase}");
//     }
//
//   }
//   catch(e){
//     print("catch data"+"${e}");
//   }
// }

}




Future<List<Friends>> request_list(Email) async {
  List<Friends> requestlist = [];


  var headers = {
    'Authorization': 'Bearer '+"${AppPreferences.getToken()!}"
  };
  var request = http.MultipartRequest('POST', Uri.parse('https://test.pearl-developer.com/mdk/public/api/request-list'));
  request.fields.addAll({
    'email': Email
   // 'email': 'govindkumar@gmail.com'
  });

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {

    await response.stream.bytesToString().then((value) async {
      var data = await jsonDecode(value);
      //print(data['users']);
      if(data['status'] == "201"){
        //print(data['users']);

        for(var item in data['friends']){
          requestlist.add(Friends.fromJson(item));
          //Users new = Users(data['status'], );
          //print('<------${item}');
        }

        print('<-------request list ${requestlist[0].name}');
      }
    });
  }
  else {
    print(response.reasonPhrase);
  }
  return requestlist

  ;
}

//SEND FRIEND REQUEST

sendfriendrequest(persionid,emailid)async{
  var headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Authorization': 'Bearer '+"${AppPreferences.getToken()!}"
  };
  var request = http.Request('POST', Uri.parse('https://test.pearl-developer.com/mdk/public/api/friend-request'));
  request.bodyFields = {
    'person_id': persionid,
    'email': emailid,
  //'Authorization': 'Bearer '+"${AppPreferences.getToken()!}"

  };
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }

}

//RESPONSE REQUEST
response(requestid,emailid,responseid)async {
  var headers = {
    'Authorization': 'Bearer '+"${AppPreferences.getToken()!}"
  };
  var request = http.MultipartRequest('POST', Uri.parse('https://test.pearl-developer.com/mdk/public/api/respond-request'));
  request.fields.addAll({
    'request_id': requestid,
    'email': emailid,
    'response_id': responseid
  });

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }

}



//ALL USER LIST

Future<List<Users>> userlist(Email) async {
  List<Users> list = [];
  var headers = {
    'Authorization': 'Bearer '+"${AppPreferences.getToken()!}"
  };
  var request = http.MultipartRequest('POST', Uri.parse('https://test.pearl-developer.com/mdk/public/api/user-list'));
  request.fields.addAll({
    'email': Email,
    //'email': 'govindkumar@gmail.com'
  });

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {

    await response.stream.bytesToString().then((value) async {
      var data = await jsonDecode(value);
      //print(data['users']);
      if(data['status'] == "201"){
        //print(data['users']);

        for(var item in data['users']){
          list.add(Users.fromJson(item));
          //Users new = Users(data['status'], );
          //print('<------${item}');
        }

        print('<------------${list[2].email}');
      }
    });
  }
  else {
    print(response.reasonPhrase);
  }
  return list;
}