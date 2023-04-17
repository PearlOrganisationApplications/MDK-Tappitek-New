
import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapittek/Utils/configuration.dart';
import '../../../Const/image_const.dart';
import '../../../Const/text_const.dart';
import '../../../Const/themescolor.dart';
import '../../../Model/GetUserPost.dart';
import '../../../Utils/app_preferences.dart';
import '../../LoginFlow/SignIn.dart';
import '../../drawernavigator/device_compatibility.dart';
import '../../userAllpost.dart';
import 'userpost.dart';
import '../Notification.dart';
import 'allsocialmedialink.dart';
import 'nfcscreen.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  final String? name;
  final File? photo;

  const Profile({Key? key, this.name, this.photo}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}


class _ProfileState extends State<Profile> {



  File? pickedImage;
  var ht, wt;
  bool onTapping = false;
  bool isEnabled = false;
  String editProfile = "Edit Profile";

  TextEditingController usernameController = TextEditingController();
  TextEditingController status = TextEditingController();



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
        pickedImage = tempImage;
      });
      Navigator.pop(context);
    } catch (error) {
      debugPrint(error.toString());
    }
  }


  Future updateprofile(name,image)async{
    try{

      var headers = {
        'Authorization': 'Bearer '+"${AppPreferences.getToken()!}"
      };
      var request = http.MultipartRequest('POST', Uri.parse('https://test.pearl-developer.com/mdk/public/api/update-profile'));
      request.fields.addAll({
        'image_ext': 'png',
        'name': name,
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
    return  SafeArea(child: Scaffold(
      appBar: AppBar(
        actions: [

          PopupMenuButton(
            // add icon, by default "3 dot" icon
            // icon: Icon(Icons.book)
              itemBuilder: (context){
                return [
                  PopupMenuItem<int>(
                    value:0,
                    child: Text("My Post"),
                  ),
                  PopupMenuItem<int>(
                    value: 1,
                    child: Text("Settings",style: TextStyle(color: Colors.grey[200]),),
                  ),

                  PopupMenuItem<int>(
                    value: 2,
                    child: Text("Logout",style: TextStyle(color: Colors.grey[200]),),
                  ),
                ];
              },
              onSelected:(value){
                if(value == 0){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => userposts(),));
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
          padding: const EdgeInsets.only(left: 1,top: 10,bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Tapittek",style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.w700,fontSize:35,color:Color(
                  0xfff8d026)),),

              SizedBox(width: 17,),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all( Color(0xffFEE572)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17.0),
                            // side: BorderSide(color: Colors.red)
                          )
                      )
                  ),
                  onPressed: (){
                    updateprofile(usernameController.text,pickedImage?.path ?? "");

                    Fluttertoast.showToast(msg: "Profile updated");


                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) =>  HomeScreen())
                    //
                    // );
                  },
                  child:  Text("Update",style: TextStyle(color: Colors.black),
                  )
              ),


            ],),
        ),
      ),
      body:
      FutureBuilder<GetUserPost?>(
          future:  createAlbum(),
          builder: (context, snapshot) {

            if (snapshot.hasData) {
              //print(snapshot.data!.posts![0].toString());
              late bool photoUrl;
              try {
                int a = snapshot.data!.posts!.isEmpty ? 0: 10 ?? 0;
                photoUrl = a==0? false:true;
              }catch (e){

              }
              print(photoUrl);
              return Column(
                children: [
                  //Commonappbar(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16,right: 16,top: 10),
                        child: Column(
                          children: [
                            //  Text("${widget.name ?? "ok"}"),
                            Row(children: [

                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    InkWell(
                                      //onTap: imagePickerOption,
                                      child: ClipOval(
                                        child:
                                        pickedImage != null
                                            ? Image.file(
                                          pickedImage!,
                                          width: 170,
                                          height: 170,
                                          fit: BoxFit.cover,
                                        ):
                                        CircleAvatar(
                                          radius: 70.0,
                                          backgroundColor: Colors.grey,

                                          child: photoUrl?
                                             Image.network(snapshot.data!.posts![0].userDetails![0].profileImage.toString(),width: 170,
                                               height: 170,fit: BoxFit.fill,) :
                                            InkWell(
                                          onTap: imagePickerOption,
                                          child: Image.asset(
                                            ImageConst().UPLOAD_IMAGES,
                                            width: 170,
                                            height: 170,
                                            fit: BoxFit.cover,
                                          ),
                                          ),
                                        ),

                                      ),
                                    ),
//snapshot.data!.posts![0].userDetails![0].name.toString()
                                    onTapping
                                        ?
                                    PositionedDirectional(
                                      bottom: 30,
                                      child: InkWell(
                                          onTap: imagePickerOption,
                                          child: Icon(Icons.camera,size: 30,color:Colors.amber,)),
                                    )

                                        : Container(),

                                  ],
                                ),
                              ),


                              SizedBox(width: 10,),
                              Expanded(
                                child: Column(children: [

                                  TextField(
                                    controller: usernameController,
                                    enabled: isEnabled,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                                      // Text(),
                                      //   Center(child: photoUrl?
                                      //                                     Text( snapshot.data!.posts![0].userDetails![0].name ?? "",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),)
                                      //                                     :Text("Name"),
                                      //                                     ),
                                     // hintText:photoUrl,
                                      hintText:photoUrl? snapshot.data!.posts![0].userDetails![0].name ?? "" :"Name"
                                    ),
                                  ),
                                  SizedBox(height: 11,),
                                  TextField(
                                    controller: status,
                                    enabled: isEnabled,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                                      hintText: 'Write something about',
                                    ),
                                  ),

                                ],),
                              )
                            ],),
                            SizedBox(height: 40,),
                            // edit(),
                            ElevatedButton(
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
                                  // Fluttertoast.showToast(msg: "Save data");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>  userpost())

                                  );
                                },
                                child:  Text("New Post",style: TextStyle(color: Colors.black),
                                )
                            ),
                            SizedBox(height: 10,),

                            Column(
                              children:
                              [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (mounted) {
                                        isEnabled = true;
                                        onTapping = !onTapping;
                                        if (onTapping) {
                                          editProfile = "Profile Preview";
                                        } else {
                                          editProfile = "Edit Profile";
                                          isEnabled = false;
                                        }
                                      }
                                    });
                                  },
                                  child: Container(

                                    height: 55,
                                    width: double.infinity,
                                    // width: constraints.maxWidth * 0.8,
                                    // margin: EdgeInsets.only(
                                    //     left: constraints.maxWidth * 0.05,
                                    //     right: constraints.maxWidth * 0.05),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(17.0),
                                      border: Border.all(color: Colors.black38),
                                      color:Color(0xffFEE572),
                                      // boxShadow:const [
                                      //   BoxShadow(
                                      //     color: Colors.black,
                                      //     blurRadius: 2.0,
                                      //     spreadRadius: 0.0,
                                      //     offset: Offset(2.0, 2.0,), // shadow direction: bottom right
                                      //   )
                                      // ],
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Text(
                                        editProfile,
                                        textAlign: TextAlign.center,
                                        style:TextStyle(color: Colors.black),
                                        // style: GoogleFonts.montserrat(
                                        //     fontSize: ResponsiveFlutter.of(context)
                                        //         .fontSize(1.6)),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 50,),
                                Container(
                                  child: Stack(children: [
                                    !onTapping
                                        ?
                                    GridView.builder(
                                      //itemCount: snapshot.data!.socialMedia.length,
                                      itemCount: 21,
                                      itemBuilder: (context, index) =>
                                          Padding(
                                            padding: const EdgeInsets.only(top: 16),
                                            child:
                                            GestureDetector(
                                              onTap: () {

                                                Navigator.push(context, MaterialPageRoute(builder: (context) =>  web()));
                                              },
                                              child: Column(
                                                children: [
                                                  Container(
                                                    child: Image.network("https://png.pngtree.com/png-vector/20221018/ourmid/pngtree-instagram-icon-png-image_6315974.png" ?? ""),
                                                    decoration: BoxDecoration(
                                                      //color: Color(0xffFF37DEFF),
                                                        borderRadius: BorderRadius.circular(10)
                                                    ),
                                                    //color: Colors.red,
                                                    height:70,width: 70,
                                                  ),
                                                  Text("App name")
                                                  // Text(snapshot.data!.socialMedia[index].appname.toString()),
                                                  // SizedBox(height: 100,width: 100,),
                                                ],
                                              ),
                                            ),
                                          ),

                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        childAspectRatio:1,
                                      ),
                                    ):
                                    onTapping
                                        ?
                                    Align(
                                      alignment: AlignmentDirectional.center,
                                      child: GestureDetector(
                                          onTap: (){
                                            // Navigator.push(context, MaterialPageRoute(builder: (context) =>  PhotoUpload()));
                                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  socialmedialink()));
                                          },
                                          child:
                                          Image.asset("assets/plusicon.jpg",)),
                                    ): Container(),

                                  ],),


                                  decoration: BoxDecoration(
                                      color: Color(0xffD9D9D9),
                                      borderRadius: BorderRadius.circular(12)
                                  ),
                                  //color: Colors.red,
                                  height: 307,width:double.infinity,
                                ),
                              ],
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
                if(snapshot.hasError){
                return Container(
                  child: Center(child: Text("Eroor")),
                );
              }
            }
          return Center(child: CircularProgressIndicator());
          }
      ),






      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<GetUserPost?>(
                      future:  createAlbum(),
                      builder: (context, snapshot) {

                        if (snapshot.hasData) {
                          late bool photoUrl;
                          try {
                            int a = snapshot.data!.posts!.isEmpty ? 0: 10 ?? 0;
                            photoUrl = a==0? false:true;
                          }catch (e){
                          }
                          print(photoUrl);
                          return Column(
                            children: [
                              //Commonappbar(),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30.0,
                                    backgroundColor: Colors.grey,
                                    child:photoUrl?
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.network(snapshot.data!.posts![0].userDetails![0].profileImage.toString(), width: 60,
                                        height: 60,fit: BoxFit.fill,),
                                    )
                                        :
                                    InkWell(
                                      //onTap: imagePickerOption,
                                      child: Image.asset(
                                        ImageConst().UPLOAD_IMAGES,
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10,),

                                  Center(child: photoUrl?
                                  Text( snapshot.data!.posts![0].userDetails![0].name ?? "",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),)
                                      :Text("Name"),
                                  ),
                                ],
                              ),

                            ],
                          );
                        }
                        else{
                          return Center(child: CircularProgressIndicator());
                        }

                      }
                  ),
                  Divider(thickness: 1.5,),
                  SizedBox(height: 25,),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Notificationscreen()));
                    },
                    child: Row(children: [
                      Icon(Icons.supervised_user_circle,size: 28,),
                      SizedBox(width: 10,),
                      Text("Complete Profile",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                    ],),
                  ),

                ],),
            ),
            ListTile(
              title:
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Notificationscreen()));
                },
                child: Row(children: [
                  Icon(Icons.supervised_user_circle,size: 28,),
                  SizedBox(width: 10,),
                  Text("My connection",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                ],),
              ),
            ),

            ListTile(
              title:
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => DeviceCompatibility()));
                },
                child: Row(children: [
                  Icon(Icons.phone_android,size: 28,),
                  SizedBox(width: 10,),
                  Text("Device compatibility",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                ],),
              ),
            ),
            ListTile(
              title:
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Notificationscreen()));
                },
                child: Row(children: [
                  Icon(Icons.help_outline_outlined,size: 28,),
                  SizedBox(width: 10,),
                  Text("Help",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                ],),
              ),
            ),
            ListTile(
              title:
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Notificationscreen()));
                },
                child: Row(children: [
                  Icon(Icons.settings,size: 28,),
                  SizedBox(width: 10,),
                  Text("Setting",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                ],),
              ),
            ),

            ListTile(
              title:
              InkWell(
                onTap: () async {
                  SharedPreferences pref = await SharedPreferences.getInstance();
                  pref.remove("email");
                  Navigator.pop(context);
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => signinscreen()));
                },
                child: Row(children: [
                  Icon(Icons.logout,size: 28,),
                  SizedBox(width: 10,),
                  Text("Logout",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                ],),
              ),
            ),
          ],
        ),
      ),

    ));
  }


  // Future registrationUser(String name,image)async
  // {
  //   var url="https://test.pearl-developer.com/mdk/public/api/update-profile";
  //   var data={
  //     "name": name,
  //     "image_ext":image,
  //
  //
  //   };
  //
  //   var bodyy=json.encode(data);
  //   var urlParse=Uri.parse(url);
  //
  //   Response response = (await http.post(
  //       urlParse,
  //       body: data,
  //     headers: {
  //       'Authorization': 'Bearer 166|69cN7AOpLMCZODnyRIvaoYZufARtWWzm1BSdcIWQ' }
  //
  //   //     var headers = {
  //   // 'Authorization': 'Bearer 166|69cN7AOpLMCZODnyRIvaoYZufARtWWzm1BSdcIWQ'
  //   // };
  //   )) as Response;
  //   var dataa=jsonDecode(response.body);
  //   print("hello"+dataa);
  // }

}


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




