import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../../Const/image_const.dart';
import '../../../Const/text_const.dart';
import '../../../Const/themescolor.dart';
import '../../../Model/GetUserPost.dart';
import '../../../Utils/app_preferences.dart';

class userpost extends StatefulWidget {
  const userpost({Key? key}) : super(key: key);

  @override
  State<userpost> createState() => _userpostState();
}

class _userpostState extends State<userpost> {
  File? pickedpic;

  void imagePickerOption() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0)),
      ),
      context: context,
      builder: (context) => SingleChildScrollView(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: Container(
            color: Colors.white,
            //height: ht * 0.25,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10,),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        // width: double.infinity,
                        height: 150,
                        decoration: const BoxDecoration(
                            color: Color(0xffECF1F6),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xffECF1F6),
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                  offset: Offset(4, 4))
                            ]),
                        child: InkWell(
                          onTap: () {
                            pickImage(ImageSource.camera);
                          },
                          child: const Icon(
                            Icons.camera,
                            color: kPrimaryColor,
                            size: 50,
                          ),
                        ),
                      ),
                      Container(
                        // width: wt * 0.30,
                        // height: ht * 0.20,
                        decoration: const BoxDecoration(
                            color: Color(0xffECF1F6),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xffECF1F6),
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                  offset: Offset(4, 4))
                            ]),
                        child: InkWell(
                            onTap: () {
                              pickImage(ImageSource.gallery);
                            },
                            child: const Icon(
                              Icons.folder_open,
                              color: kPrimaryColor,
                              size: 50,
                            )),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        OPENCAMERA,
                        style: GoogleFonts.poppins(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        OPENFILE,
                        style: GoogleFonts.poppins(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  pickImage(ImageSource imageType) async {
    try {
      final photo =
      await ImagePicker().pickImage(source: imageType, imageQuality: 20);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedpic = tempImage;
      });
      Navigator.pop(context);
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  TextEditingController userstatusController = TextEditingController();


  Future updateprofile(userstatus,image)async{
    try{

      var headers = {
        'Authorization': 'Bearer '+"${AppPreferences.getToken()!}"
      };
      var request = http.MultipartRequest('POST', Uri.parse('https://test.pearl-developer.com/mdk/public/api/add-post'));
      request.fields.addAll({
        'image_ext': 'png',
        'text': userstatus
      });
      request.files.add(await http.MultipartFile.fromPath('image',image));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print("api statussss...govind"+await response.stream.bytesToString());
      }
      else {
        print("update status......."+response.reasonPhrase.toString());
        print("failedddd");
      }

    }
    catch(e){
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold (
      body: FutureBuilder<GetUserPost?>(
          future:  createAlbum(),
          builder: (context, snapshot) {

            if (snapshot.hasData) {
              late bool photoUrl;
              try {
                int a = snapshot.data!.posts!.isEmpty ? 0: 10 ?? 0;
                photoUrl = a==0? false:true;
              }catch (e){

              }
              //print(photoUrl);

              return Column(
                children: [
                  appbarwidget(context,updateprofile,userstatusController,pickedpic),
                  Expanded(child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        Column(children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16,right: 16),
                            child: Row(children: [
                              CircleAvatar(
                              radius: 30.0,
                              backgroundColor: Colors.grey,
                              child: photoUrl?
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child:  Image.network(snapshot.data!.posts![0].userDetails![0].profileImage.toString(),height: 60,width:60,fit: BoxFit.fill,)):
                                  Icon(Icons.person)
                            ),


                              /* Container(
                child:
               // SvgPicture.asset("assets/ell.svg"),
               Image.asset("assets/dp.jpg",fit:BoxFit.fill,),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.red,),
                height: 70,width: 70,),*/
                              SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(child: photoUrl?
                                  Text( snapshot.data!.posts![0].userDetails![0].name ?? "",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),)
                                      :Text("Name"),
                                  ),
                                  //Text(snapshot.data!.posts![0].userDetails![0].name.toString()),

                                ],),

                            ],),

                          ),
                          SizedBox(height: 10,),
                          TextField(
                            controller: userstatusController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              floatingLabelBehavior: FloatingLabelBehavior.never, //Hides label on focus or if filled
                              labelText: "What's on your mind ?",
                              filled: true, // Needed for adding a fill color
                              //fillColor: Colors.grey.shade800,
                              isDense: true,  // Reduces height a bit
                              // border: OutlineInputBorder(
                              //   // borderSide: BorderSide.none,              // No border
                              //   borderRadius: BorderRadius.circular(12),  // Apply corner radius
                              // ),
                            ),
                          ),


                        ],),
                        Container(
                          child:

                          InkWell(
                            onTap: imagePickerOption,
                            child: Container(
                              child:
                              pickedpic != null
                                  ? Image.file(
                                pickedpic!,
                                width: 170,
                                height: 170,
                                fit: BoxFit.cover,
                              )
                                  : InkWell(
                                //onTap: imagePickerOption,
                                child: Image.asset(
                                  ImageConst().UPLOAD_IMAGES,
                                  width: 170,
                                  height: 170,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),

                          height: 300,
                          width: double.infinity,
                          //color: Colors.deepOrange,
                        ),

                      ],),
                    ),
                  )),
                ],
              );
            }
            else{
              return Center(child: CircularProgressIndicator());
            }

          }
      ),





    ));
  }
}



Widget appbarwidget(context,updateprofile,userstatusController,pickedpic) {
  return
    Column(
      children: [
        Padding(
          padding:  EdgeInsets.only(left: 16,right: 16,top: 10,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.cancel_outlined,size: 40,)),
              SizedBox(width: 10,),
              Text("Create Post",style: TextStyle(fontWeight: FontWeight.w700,fontSize:30,color:Color(
                  0xfff8d026)),),
              SizedBox(width: 10,),
              SizedBox(
                //width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all( Color(0xffFEE572)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              // side: BorderSide(color: Colors.red)
                            )
                        )
                    ),
                    onPressed: (){
                      updateprofile(userstatusController.text,pickedpic!.path);
                      Fluttertoast.showToast(msg: "New post");

                      Navigator.pop(context);
                      // Fluttertoast.showToast(msg: "Save data");
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(builder: (context) =>  userpost()));
                    },
                    child:  Text("Post",style: TextStyle(color: Colors.black),
                    )
                ),
              ),

            ],),
        ),
        Divider(thickness: 2,)
      ],
    );
}


Future<GetUserPost?> createAlbum() async {
  var headers = {
    'Authorization': 'Bearer '+"${AppPreferences.getToken()!}"  };
  final response = await http.post(
    Uri.parse('https://test.pearl-developer.com/mdk/public/api/get-user-posts'),
    headers: headers,

  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    return GetUserPost.fromJson(jsonDecode(response.body));
  }
}