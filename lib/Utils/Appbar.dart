import 'package:flutter/material.dart';

class Commonappbar extends StatefulWidget {
  const Commonappbar({Key? key}) : super(key: key);

  @override
  State<Commonappbar> createState() => _CommonappbarState();
}

class _CommonappbarState extends State<Commonappbar> {
  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(children: [
          InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back,size: 40,)),
          SizedBox(width: 10,),
          Text("Tapittek",style: TextStyle(fontWeight: FontWeight.w700,fontSize:35,color:Color(
              0xfff8d026)),),
          /*  Spacer(),
        InkWell(
            onTap: ()
            {
              print("hello");
            },
            child: Image.asset("assets/send.jpg",fit:BoxFit.fill,)),
        SizedBox(width: 10,),
        Image.asset("assets/Vec.jpg",fit:BoxFit.fill,),*/




        ],),
      );
  }
}
