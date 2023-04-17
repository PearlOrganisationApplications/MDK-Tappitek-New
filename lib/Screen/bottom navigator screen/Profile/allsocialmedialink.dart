import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapittek/Screen/bottom%20navigator%20screen/Profile/profile.dart';
import '../../../Model/socialmediaappsmodel.dart';
import '../../../Utils/Appbar.dart';
import 'package:http/http.dart' as http;

class socialmedialink extends StatefulWidget {
  const socialmedialink({Key? key}) : super(key: key);

  @override
  State<socialmedialink> createState() => _socialmedialinkState();
}
Future<SocialMediaapps> fetchAlbum() async {
  final response = await http.get(
      Uri.parse('https://test.pearl-developer.com/mdk/public/api/get-apps'));

  if (response.statusCode == 200) {
    print(response.body);

    var venueData = json.decode(response.body);
    var c = venueData["SocialMedia"];

    for (var i in c) {
      var appname = i["appname"];
      var iconImage = i["icon_image"];
      print("HEllo hhh${appname}");
    }

    //userArtworksListTemp[index]['venue_name'] = venueData[0]['title']['rendered'];
    return SocialMediaapps.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class _socialmedialinkState extends State<socialmedialink> {
  // late CompleteBookingViewModel completeBookingViewModel;
  //late SocialMediaappViewModel socialMediaappViewModel;

  @override
  Widget build(BuildContext context) {
   // socialMediaappViewModel = context.watch<SocialMediaappViewModel>();

    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Commonappbar(),
          body(),
          Expanded(child:
          FutureBuilder<SocialMediaapps>(
              future: fetchAlbum(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return
                    GridView.builder(
                      itemCount: snapshot.data!.socialMedia.length,
                      itemBuilder: (context, index) =>
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child:
                            GestureDetector(
                              onTap: () async {
                                final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                                prefs.setString(
                                    "appname",
                                    snapshot
                                        .data!.socialMedia![index].appname
                                        .toString());
                                _showBottomSheetDialog(
                                    img: snapshot
                                        .data!.socialMedia![index].iconImage
                                        .toString(),
                                    txt: snapshot
                                        .data!.socialMedia![index].appname
                                        .toString(),
                                    url: snapshot
                                        .data!.socialMedia![index].url
                                        .toString(), context: context);

                              },
                              child: Column(
                                children: [
                                  Container(
                                    child: Image.network(snapshot.data!.socialMedia[index].iconImage.toString()),
                                    decoration: BoxDecoration(
                                      //color: Color(0xffFF37DEFF),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    //color: Colors.red,
                                    height:70,width: 70,
                                  ),
                                  Text(snapshot.data!.socialMedia[index].appname.toString()),
                                  // SizedBox(height: 100,width: 100,),
                                ],
                              ),
                            ),
                          ),

                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio:1,
                      ),
                    );
                }

                else {
                  return Center(child: CircularProgressIndicator());
                }
              })),
        ],
      ),
    ));
  }
}

Widget body() {
  return Padding(
    padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
    child: Column(
      children: [
        Text(
          " Choose a link type",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Color(0xff000000)),
        ),

        // Text(
        //   "${completeBookingViewModel.completebokingmodel?.response!
        //       .cancelbookinglist![index].poojaTitle ?? ""}",
        //

        // Text(socialMediaappViewMod
        //   ,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color:Color(0xff000000)),),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 50,
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(17)),
              hintText: 'search',
            ),
          ),
        ),
        SizedBox(
          height: 45,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: Image.asset(
                "assets/contact.jpg",
              ),
              decoration: BoxDecoration(
                  color: Color(0xffFEE572),
                  borderRadius: BorderRadius.circular(10)),
              //color: Colors.red,
              height: 88, width: 88,
            ),
            Container(
              child: Image.asset(
                "assets/conta.jpg",
              ),
              decoration: BoxDecoration(
                  color: Color(0xffD9D9D9),
                  borderRadius: BorderRadius.circular(10)),
              //color: Colors.red,
              height: 88, width: 88,
            ),
          ],
        )
      ],
    ),
  );
}

  _showBottomSheetDialog(
      {required String img, required String txt, required String url,required BuildContext context}) {
    TextEditingController usernameController = TextEditingController();
    // Future<String> getData() {
    //   return Future.delayed(Duration(seconds: 2), () {
    //     return "I am data";
    //     // throw Exception("Custom Error");
    //   });
    // }

    return showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          //var _namecontroller;
          return Padding      (
            padding:
            const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Column(
              children: [
                Image.network(
                  img,
                  width: 80,
                  height: 80,
                ),
                Text(
                  txt,
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                  ),
                ),
                Text(
                  url,
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'User Name',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                   // ApiServicess.apiCallUersData(username: usernameController.text);
                    Navigator.pop(context, MaterialPageRoute(builder: (context) => Profile(name: usernameController.text,)));
                    //Navigator.of(context).popUntil((route) => route.settings.name == Profile(name: usernameController.text,));

                    },
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                        child: Text(
                          "Save",
                          style: GoogleFonts.montserrat(
                              fontSize: 15, color: Colors.white),
                        )),
                  ),
                )
              ],
            ),
          );
        });
  }

