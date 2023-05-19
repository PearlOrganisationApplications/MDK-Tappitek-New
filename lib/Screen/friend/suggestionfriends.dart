import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapittek/Model/UserlistModel.dart';
import 'package:http/http.dart' as http;

import '../../Const/image_const.dart';
import 'frienslist.dart';

class AddnewFriend extends StatefulWidget {
  const AddnewFriend({Key? key}) : super(key: key);

  @override
  State<AddnewFriend> createState() => _AddnewFriendState();
}

class _AddnewFriendState extends State<AddnewFriend> {
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
    return SafeArea(child: Scaffold(body:
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
          Text("Suggestion ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),

        ],),
        SizedBox(height: 5,),
        Divider(thickness: 1.5,),



        FutureBuilder<List<Users>>(
            future: userlist(Email),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return  Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(top: 2,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("People You May Know ",style: TextStyle(fontSize: 23,fontWeight: FontWeight.w500),),
                          SizedBox(height: 10,),
                          ListView.separated(
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 14,);

                              //Divider(thickness: 1.5,);
                            },
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context , int index){
                              return
                                Row(
                                  children: [



                                    CircleAvatar(
                                      radius: 40.0,
                                      backgroundImage:

                                      NetworkImage(snapshot.data![index].profileImage??""
                                        // "https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg"
                                      ),
                                      backgroundColor: Colors.grey,
                                    ),
                                    SizedBox(width: 10,),
                                    Expanded(
                                      flex:1,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                           Text(snapshot.data![index].name ?? "",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                          //Text("Govind Kumar",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),

                                          Row(
                                            //crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                          backgroundColor: MaterialStateProperty.all( Colors.greenAccent),
                                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(12.0),
                                                                // side: BorderSide(color: Colors.red)
                                                              )
                                                          )
                                                      ),
                                                      onPressed: (){},
                                                      child:  Text("Add Friend",style: TextStyle(color: Colors.black),)
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
                                                          backgroundColor: MaterialStateProperty.all( Color(0xffed5555)),
                                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(12.0),
                                                                // side: BorderSide(color: Colors.red)
                                                              )
                                                          )
                                                      ),
                                                      onPressed: (){},
                                                      child:  Text("Remove",style: TextStyle(color: Colors.black),)
                                                  ),
                                                ),
                                              ),
                                            ],),
                                        ],
                                      ),
                                    ),

                                  ],);

                            },
                            itemCount: snapshot.data!.length,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              else {
                return Center(child: CircularProgressIndicator(),);
              }
            }
        ),



      ],),
    ),));
  }
}



