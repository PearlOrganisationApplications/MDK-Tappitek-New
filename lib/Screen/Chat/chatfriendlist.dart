import 'package:flutter/material.dart';

import 'my_chat.dart';
class chatfriendlist extends StatefulWidget {
  const chatfriendlist({Key? key}) : super(key: key);

  @override
  State<chatfriendlist> createState() => _chatfriendlistState();
}

class _chatfriendlistState extends State<chatfriendlist> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(body:
    Container(
      padding: EdgeInsets.only(left: 16,right: 16),
      child: Column(children: [
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back,size: 30,)),
          //SizedBox(width: 10,),
          Text("Chat",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
            Icon(Icons.settings),

        ],),
         SizedBox(height: 10,),
        // Divider(thickness: 1.5,),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 2,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 // Text(" 1,236 friends",style: TextStyle(fontSize: 23,fontWeight: FontWeight.w500),),
                  SizedBox(height: 10,),
                  ListView.separated(
                    separatorBuilder: (context, index) {
                      return // SizedBox(height: 14,);
                        Divider();
                    },
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context , int index){
                      return
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>BabySitterMyChat()));
                          },
                          child: Row(
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
                                Text("Vipin Kumar",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                SizedBox(height: 5,),

                              ],),

                          ],),
                        );

                    },
                    itemCount: 35,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],),
    ),));
  }
}
