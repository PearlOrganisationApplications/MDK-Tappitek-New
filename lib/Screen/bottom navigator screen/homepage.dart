import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapittek/Utils/configuration.dart';
import '../../Const/image_const.dart';
import '../../Model/GetUserPost.dart';
import '../../Model/alluserpostModel.dart';
import '../../Utils/Api_collection.dart';
import '../../Utils/app_preferences.dart';
import '../../Utils/configuration.dart';
import '../../Utils/configuration.dart';
import '../../Utils/configuration.dart';
import '../Chat/chatfriendlist.dart';
import '../Chat/my_chat.dart';
import '../Commentsbox.dart';
import '../LoginFlow/SignIn.dart';
import '../drawernavigator/device_compatibility.dart';
import 'Notification.dart';
import 'package:http/http.dart' as http;


import 'Profile/profile.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}
// Future<Alluserpost?> fetchAlbumn() async {
//
//   var headers = {
//     'Authorization': 'Bearer 166|69cN7AOpLMCZODnyRIvaoYZufARtWWzm1BSdcIWQ'
//   };
//   var request = http.MultipartRequest('POST', Uri.parse('https://test.pearl-developer.com/mdk/public/api/get-all-posts'));
//
//   request.headers.addAll(headers);
//
//   http.StreamedResponse response = await request.send();
//
//   if (response.statusCode == 200) {
//     print(await response.stream.bytesToString());
//   }
//   else {
//     print(response.reasonPhrase);
//   }
//
// }


class _homepageState extends State<homepage>with TickerProviderStateMixin  {
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


  late final AnimationController _controller = AnimationController(
      duration:  Duration(milliseconds: 200), vsync: this, value: 1.0);

  bool _isFavorite = false;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }



  Future<bool> _willPopCallback() async {
    exit(0);
    // await showDialog or Show add banners or whatever
    // then
    return true; // return true if the route to be popped
  }

  @override
  Widget build(BuildContext context) {

    bool _isTap = false;
    Color _favIconColor = Colors.grey;


    return WillPopScope(
      onWillPop: _willPopCallback,

      child: SafeArea(child: Scaffold(
        appBar: AppBar(
          // actions: [
          //
          //   PopupMenuButton(
          //     // add icon, by default "3 dot" icon
          //     // icon: Icon(Icons.book)
          //       itemBuilder: (context){
          //         return [
          //           /*PopupMenuItem<int>(
          //             value:0,
          //             child: Text("My account"),
          //           ),
          //           PopupMenuItem<int>(
          //             value: 1,
          //             child: Text("Settings"),
          //           ),
          //
          //           PopupMenuItem<int>(
          //             value: 2,
          //             child: Text("Logout"),
          //           ),*/
          //         ];
          //       },
          //       onSelected:(value){
          //         if(value == 0){
          //           print("My account menu is selected.");
          //         }else if(value == 1){
          //           print("Settings menu is selected.");
          //         }else if(value == 2){
          //           print("Logout menu is selected.");
          //         }
          //       }
          //   ),
          // ],
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Padding(
            padding: const EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
            child: Row(children: [
              //Text("Tapittek",style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.w700,fontSize:35,color:Color(
              //0xfff8d026)),),

              // Spacer(),
              // InkWell(
              //     onTap: (){
              //       Navigator.push(context, MaterialPageRoute(builder: (context)=>chatfriendlist()));
              //     },
              //     child: Icon(Icons.chat)),
            ],),
          ),
        ),
        body:
        FutureBuilder<GetUserPost?>(
            future:  createAlbum(Email!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {

                return
                  Column(
                    children: [
                      //Commonappbar(),

                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              children: [
                                // listview(),

                                Container(
                                  //padding: EdgeInsets.only(top: 23),
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) {
                                      return Divider(thickness: 1.5,);
                                    },
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, int index) {
                                      return
                                        Column(children: [
                                          // Text("Govind"),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16, right: 16),
                                                child: Row(children: [

                                                  InkWell(
                                                    onTap: ()
                                                    {
                                                      Navigator.push(context, MaterialPageRoute(
                                                          builder: (context) => Profile()));
                                                    },
                                                    child: CircleAvatar(
                                                      backgroundColor: Colors.grey,
                                                      backgroundImage:snapshot.data!.posts![index].userDetails![0].profileImage.toString().isNotEmpty
                                                          ? NetworkImage(snapshot.data!.posts![index].userDetails![0].profileImage.toString())
                                                          : null,
                                                    ),
                                                  ),

                                                  SizedBox(width: 10,),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(snapshot.data!.posts![index].userDetails![0].name.toString()),

                                                      //Text("Deven mestry is with Mahesh\nJoshi."),

                                                    ],),

                                                ],),
                                              ),

                                              SizedBox(height: 10,),
                                              Padding(
                                                padding:  EdgeInsets.only(
                                                    left: 16, bottom: 5),
                                                child: Text(snapshot.data!.posts![index].text.toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 14),),

                                              ),

                                              //SvgPicture.asset("assets/car.svg"),
                                              //Image.asset("assets/picture.jpg"),
                                              SizedBox(child:
                                              Image.network(
                                                snapshot.data!.posts![index].postImage.toString(),
                                                fit: BoxFit.fill,)
                                                , width: double.infinity,
                                                height: 400,
                                              ),

                                              //NetworkImage(snapshot.data!.posts![index].PROFILEIMAGE+image.toString()),


                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [


                                                        GestureDetector(
                                                          onTap: () {
                                                            likepost(Email,
                                                                snapshot.data!.posts![index].id.toString()
                                                            );
                                                            // print("user login emaillllll"+"${Email}");

                                                            setState(() {
                                                              _isFavorite = !_isFavorite;
                                                            });
                                                            _controller
                                                                .reverse()
                                                                .then((value) => _controller.forward());
                                                          },
                                                          child: Row(
                                                            children: [
                                                              ScaleTransition(
                                                                scale: Tween(begin: 0.7, end: 1.0).animate(
                                                                    CurvedAnimation(parent: _controller, curve: Curves.easeOut)),
                                                                child: _isFavorite
                                                                    ? const Icon(
                                                                  Icons.favorite,
                                                                  size: 30,
                                                                  color: Colors.red,
                                                                )
                                                                    : const Icon(
                                                                  Icons.favorite_border,
                                                                  size: 30,
                                                                ),
                                                              ),
                                                              Text(" Like"),
                                                            ],
                                                          ),
                                                        ),



                                                        SizedBox(width: 30,),
                                                        InkWell(
                                                            onTap:(){
                                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Commentsbox()));
                                                            },
                                                            child: Row(
                                                              children: [
                                                                Icon(Icons.comment),
                                                                Text(" Comment"),
                                                              ],
                                                            )),


                                                        SizedBox(width: 30,),
                                                        // Image.asset("assets/share.jpg",fit:BoxFit.fill,),
                                                      ],),

                                                    SizedBox(height: 16,),

                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "${snapshot.data!.posts![index].likeCount.toString()}",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight
                                                                  .w600,
                                                              fontSize: 11),),

                                                        Text("4 comments",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight
                                                                  .w400,
                                                              fontSize: 11),),

                                                      ],)
                                                  ],
                                                ),
                                              )

                                            ],
                                          ),

                                        ],);
                                    },
                                    itemCount: snapshot.data!.posts!.length,
                                    //itemCount: 10,

                                  ),

                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
              }
//govind
              else{
                return Center(child: CircularProgressIndicator());

              }


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
                        future:  userprofile(),
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
                        // Navigator.push(context, MaterialPageRoute(
                        //     builder: (context) => Notificationscreen()));
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
                    // Navigator.push(context, MaterialPageRoute(
                    //     builder: (context) => Notificationscreen()));
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
                    Text("Device compatibility ",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                  ],),
                ),
              ),
              ListTile(
                title:
                InkWell(
                  onTap: (){
                    // Navigator.push(context, MaterialPageRoute(
                    //     builder: (context) => Notificationscreen()));
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
                    // Navigator.push(context, MaterialPageRoute(
                    //     builder: (context) => Notificationscreen()));
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
      )
      ),
    );

  }
}

Future<GetUserPost?> createAlbuma(Email ) async {
 // var token;
  var headers = {
    'Authorization': 'Bearer '+"${AppPreferences.getToken()!}"
  };
  var request = http.MultipartRequest('POST', Uri.parse('https://test.pearl-developer.com/mdk/public/api/get-all-posts'));
  request.fields.addAll({
    'email': Email
    //'email': 'govindkumar@gmail.com'
  });
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    print("home page posts"+await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }
}


Future<GetUserPost?> createAlbum(String Email) async {
  Dio dio = Dio();

  try {
    // var token;
    var headers = {
      'Authorization': 'Bearer ${AppPreferences.getToken()!}',
    };

    var formData = FormData.fromMap({
      'email': Email,
      //'email': 'govindkumar@gmail.com'
    });

    Response response = await dio.post(
      'https://test.pearl-developer.com/mdk/public/api/get-all-posts',
      data: formData,
      options: Options(headers: headers),
    );

    if (response.statusCode == 200) {
      print("home page posts: ${response.data}");
    } else {
      print(response.statusMessage);
    }

    // Parse and return the GetUserPost object
    return GetUserPost.fromJson(response.data);
  } catch (e) {
    // Handle any errors
    print(e);
    return null;
  }
}











/*Future<GetUserPost?> userprofile() async {
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
}*/



Future<GetUserPost?> userprofile() async {
  // Create Dio instance
  Dio dio = Dio();

  // Define the headers
  Map<String, String> headers = {
    'Authorization': 'Bearer '+"${AppPreferences.getToken()!}"
  };

  // Define the API endpoint
  String url = 'https://test.pearl-developer.com/mdk/public/api/get-user-posts';

  try {
    // Make the API call
    Response response = await dio.get(url, options: Options(headers: headers));

    // Handle the response
    if (response.statusCode == 200) {
      return GetUserPost.fromJson(response.data);

      // API call successful
      print(response.data);
    } else {
      // API call failed
      print('API call failed with status code ${response.statusCode}');
    }
  } catch (error) {
    // Handle any errors
    print('An error occurred: $error');
  }
}






Future likepost(email,id) async {var headers = {
  'Authorization': 'Bearer '+"${AppPreferences.getToken()!}"
};
var request = http.MultipartRequest('POST', Uri.parse('https://test.pearl-developer.com/mdk/public/api/like-post'));
request.fields.addAll({
  'email': email,
  'post_id': id,
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











