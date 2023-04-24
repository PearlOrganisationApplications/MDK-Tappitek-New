import 'package:flutter/material.dart';
class Yourfriend extends StatefulWidget {
  const Yourfriend({Key? key}) : super(key: key);

  @override
  State<Yourfriend> createState() => _YourfriendState();
}

class _YourfriendState extends State<Yourfriend> {
  @override
  Widget build(BuildContext context) {
    return
      SafeArea(child: Scaffold(body:
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
                  Text(" 1,236 friends",style: TextStyle(fontSize: 23,fontWeight: FontWeight.w500),),
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
                            NetworkImage("https://images.unsplash.com/photo-1466112928291-0903b80a9466?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8cHJvZmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60"),
                            backgroundColor: Colors.transparent,
                          ),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Text("Govind Kumar"),
                              Text("Tarun Gupta",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                              SizedBox(height: 5,),

                            ],),

                        ],);

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
