import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/My_Friend_List_Model.dart';
import '../../Utils/app_preferences.dart';
class Yourfriend extends StatefulWidget {
  const Yourfriend({Key? key}) : super(key: key);

  @override
  State<Yourfriend> createState() => _YourfriendState();
}

class _YourfriendState extends State<Yourfriend> {

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
    return
      SafeArea(child: Scaffold(body:
      FutureBuilder<List<Friends>>(
          future: myfriendlist(Email),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return
                Container(
                  padding: EdgeInsets.only(left: 16,right: 16),
                  child: Column(children: [
                    SizedBox(height: 5,),
                    Row(children: [
                      InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back,size: 30,)),
                      SizedBox(width: 10,),
                      Text("Your Friends ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),

                    ],),
                    SizedBox(height: 5,),
                    Divider(thickness: 1.5,),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(top: 2,),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(snapshot.data!.length.toString()+" friends",style: TextStyle(fontSize: 23,fontWeight: FontWeight.w500),),
                              SizedBox(height: 10,),
                              ListView.separated(
                                separatorBuilder: (context, index) {
                                  return // SizedBox(height: 14,);
                                    Divider();
                                },
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context , int index){
                                  return Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 40.0,
                                        backgroundImage:
                                        NetworkImage(
                                            snapshot.data![index].profileImage??""),
                                            //"https://images.unsplash.com/photo-1466112928291-0903b80a9466?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8cHJvZmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60"),
                                        backgroundColor: Colors.grey,
                                      ),
                                      SizedBox(width: 10,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(snapshot.data![index].name??"",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                         // Text("Tarun Gupta",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                          SizedBox(height: 5,),

                                        ],),

                                    ],);

                                },
                                itemCount:snapshot.data!.length
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],),
                );


            }
            else {
              return Center(child: CircularProgressIndicator(),);
            }
          }
      ),


      )
      );
  }

  Future<List<Friends>> myfriendlist(Email) async {
    List<Friends> friendlist = [];


    var headers = {
      'Authorization': 'Bearer '+"${AppPreferences.getToken()!}"
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://test.pearl-developer.com/mdk/public/api/my-friend-list'));
    request.fields.addAll({
      'email': Email,
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
            friendlist.add(Friends.fromJson(item));
            //Users new = Users(data['status'], );
            //print('<------${item}');
          }

          print('<------------${friendlist[0].email}');
        }
      });
    }
    else {
      print(response.reasonPhrase);
    }
    return friendlist;
  }


}
