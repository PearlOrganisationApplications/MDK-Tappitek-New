import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tapittek/Screen/friend/suggestionfriends.dart';

import 'Allfriendrequests.dart';
import 'Yourfriend.dart';
class friendslist extends StatefulWidget {
  const friendslist({Key? key}) : super(key: key);

  @override
  State<friendslist> createState() => _friendslistState();
}

class _friendslistState extends State<friendslist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child:
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 16,right: 16,top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Friends",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w700),),
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
                              backgroundColor: MaterialStateProperty.all( Colors.lightBlue),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(19.0),
                                    // side: BorderSide(color: Colors.red)
                                  )
                              )
                          ),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddnewFriend()));
                          },
                          child:  Text("Suggestions",style: TextStyle(color: Colors.black),)
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
                              backgroundColor: MaterialStateProperty.all( Colors.grey),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(19.0),
                                    // side: BorderSide(color: Colors.red)
                                  )
                              )
                          ),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Yourfriend()));
                          },
                          child:  Text("Your Friends",style: TextStyle(color: Colors.black),)
                      ),
                    ),
                  ),

                ],),
              SizedBox(height: 7,),
              Divider(thickness: 2,),

              Container(
                padding: EdgeInsets.only(top: 16,),
                child: ListView.separated(
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
                          NetworkImage("https://images.unsplash.com/photo-1618641986557-1ecd230959aa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80"),
                          backgroundColor: Colors.transparent,
                        ),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Text("Govind Kumar"),
                            Text("Govind Kumar",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                            SizedBox(height: 5,),
                            Row(
                              //crossAxisAlignment: CrossAxisAlignment.start,
                             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Text("Nidhi",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w700),),
                                SizedBox(
                                  height: 40,
                                  width: 110,
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
                                      child:  Text("Confirm",style: TextStyle(color: Colors.black),)
                                  ),
                                ),
                                SizedBox(width: 10,),
                                //Spacer(),
                                SizedBox(
                                  height: 40,
                                  width: 110,
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
                                      child:  Text("Delete",style: TextStyle(color: Colors.black),)
                                  ),
                                ),
                              ],),
                          ],),
                      ],);
                  },
                  itemCount: 5,
                ),
              ),
              SizedBox(height: 16,),
              SizedBox(
                height: 40,
                width: double.infinity,
                child:
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all( Colors.grey),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              // side: BorderSide(color: Colors.red)
                            )
                        )
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AllFriendrequest()));
                    },
                    child:  Text("See All",style: TextStyle(color: Colors.black),)
                ),
              ),
              SizedBox(height: 10,),
              Divider(thickness: 1,),
SizedBox(height: 10,),
              Text("People You May Know",style: TextStyle(fontSize: 27,fontWeight: FontWeight.w500),),

              Container(
                padding: EdgeInsets.only(top: 23,),
                child: ListView.separated(
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
                          NetworkImage("https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg"),
                          backgroundColor: Colors.transparent,
                        ),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Text("Govind Kumar"),
                            Text("Govind Kumar",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                            SizedBox(height: 5,),
                            Row(
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Text("Nidhi",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w700),),
                                SizedBox(
                                  height: 40,
                                  width: 110,

                                  // width: double.infinity,
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
                                SizedBox(width: 10,),
                                SizedBox(
                                  height: 40,
                                  width: 110,

                                  //width: double.infinity,
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

                              ],),
                          ],),

                      ],);

                  },
                  itemCount: 51,
                ),
              ),

            ],),

        ),
      ),),);
  }
}
