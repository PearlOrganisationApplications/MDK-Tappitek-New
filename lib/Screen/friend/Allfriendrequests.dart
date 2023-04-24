import 'package:flutter/material.dart';
class AllFriendrequest extends StatefulWidget {
  const AllFriendrequest({Key? key}) : super(key: key);

  @override
  State<AllFriendrequest> createState() => _AllFriendrequestState();
}

class _AllFriendrequestState extends State<AllFriendrequest> {
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
          Text("Requests ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),

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
                  Text("Friend requests ",style: TextStyle(fontSize: 23,fontWeight: FontWeight.w500),),
                  SizedBox(height: 10,),
                  ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 14,);

                      //Divider(thickness: 1.5,);
                    },
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context , int index){
                      return Row(
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
                                        child:  Text("Confirm",style: TextStyle(color: Colors.black),)
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  SizedBox(
                                    height: 40,
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
                                        child:  Text("Delete",style: TextStyle(color: Colors.black),)
                                    ),
                                  ),

                                ],),
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
