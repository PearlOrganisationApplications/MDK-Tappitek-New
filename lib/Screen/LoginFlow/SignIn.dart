import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tapittek/Screen/LoginFlow/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../Utils/app_preferences.dart';
import '../homescreen.dart';

class signinscreen extends StatefulWidget {
  const signinscreen({Key? key}) : super(key: key);

  @override
  State<signinscreen> createState() => _signinscreenState();
}

class _signinscreenState extends State<signinscreen> {

  TextEditingController useremailController = TextEditingController();

  TextEditingController userpasswordController = TextEditingController();
  bool _obscured = false;
  final textFieldFocusNode = FocusNode();

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

/*  Future signin(String email,String password,)async{
    try{

      var request = http.MultipartRequest('POST', Uri.parse('https://test.pearl-developer.com/mdk/public/api/signin'));
      request.fields.addAll({
        'email': email,
        'password': password,
      });

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print("govind status  ""${await response.stream.bytesToString()}");
        print('Login successfully');
        print("status code.......""${response.statusCode}");
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  HomeScreen())
        );
      }
      else {
        print("status code signin....""${response.statusCode}");
        print("govind signin "+response.reasonPhrase!);
        print('Login failed');
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) =>  HomeScreen())
        // );
      }

    }
    catch(e){
      print(e);
    }
  }*/

  signUp(email, password) async {
    var body = json.encode({
      "email": email,
      "password": password,
    });
    var  url = "https://test.pearl-developer.com/mdk/public/api/signin";
        await http.post(Uri.parse(url),headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },

      body: body,
    )
        .then((response) {
      var body = json.decode(response.body);
      print("govind govind.. "+"${response.statusCode}");
      print("govind govind "+response.body);

      Map<String,dynamic> data = {
        'token' : body['token']};
      if (response.statusCode == 200) {
        //print("govind status " "${response.statusCode}");
        // loading = false;
        AppPreferences.saveToken(token: body['token']);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext ctx) => HomeScreen()));
      } else {
        final snackBar = SnackBar(content: Text(body['message']));
        Fluttertoast.showToast(msg: "userid/password incorrect");
        // _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Create account",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xffA29EB6),
                      fontSize: 16),
                ),
                SizedBox(
                  width: 6,
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => signupscreen()));
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xffFF8A00),
                          fontSize: 16),
                    )),
              ],
            ),
            //Text("Already have an account?",style: TextStyle(fontWeight: FontWeight.w500,color: Color(0xffA29EB6),fontSize: 16),),
            padding: EdgeInsets.only(left: 22,bottom: 30),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 55,
              ),
              child: Column(
                children: [
                  Text(
                    "Sign In",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                  ),
                  SizedBox(
                    height: 33,
                  ),
                  TextField(
                    controller: useremailController,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      //Hides label on focus or if filled
                      labelText: "Enter your id",
                      filled: true,
                      // Needed for adding a fill color
                      //fillColor: Colors.grey.shade800,
                      isDense: true,
                      // Reduces height a bit
                      border: OutlineInputBorder(
                        // borderSide: BorderSide.none,              // No border
                        borderRadius:
                            BorderRadius.circular(12), // Apply corner radius
                      ),
                      prefixIcon: Icon(Icons.person, size: 24),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),



                  TextField(
                    controller: userpasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _obscured,
                    focusNode: textFieldFocusNode,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      //Hides label on focus or if filled
                      labelText: "Password",
                      filled: true,
                      // Needed for adding a fill color
                      //fillColor: Colors.grey.shade800,
                      isDense: true,
                      // Reduces height a bit
                      border: OutlineInputBorder(
                        // borderSide: BorderSide.none,              // No border
                        borderRadius:
                            BorderRadius.circular(12), // Apply corner radius
                      ),
                      prefixIcon: Icon(Icons.lock_rounded, size: 24),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                        child: GestureDetector(
                          onTap: _toggleObscured,
                          child: Icon(
                            _obscured
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xffFEE572)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17.0),
                              // side: BorderSide(color: Colors.red)
                            ))),
                        onPressed: () async {


                          //signin(
                          //
                          //
                          //
                          // .text.toString(), userpasswordController.text.toString());

                          print(useremailController.text);
                          print(userpasswordController.text);
                          signUp(
                            useremailController.text,
                            userpasswordController.text,
                          );
                          SharedPreferences pref =
                          await SharedPreferences.getInstance();
                          pref.setString("email", useremailController.text);


                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(builder: (context) =>  HomeScreen())
                          // );
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(color: Colors.black),
                        )),
                  ),
                  SizedBox(height: 24),
                  Row(children: <Widget>[
                    Expanded(
                        child: Divider(
                      thickness: 1.5,
                    )),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Or sign up with",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xffA29EB6),
                          fontSize: 16),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: Divider(
                      thickness: 1.5,
                    )),
                  ]),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/fb.jpg",
                          fit: BoxFit.fill,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.cyan,
                            borderRadius: BorderRadius.circular(10)),
                        //color: Colors.red,
                        height: 60, width: 60,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Image.asset(
                          "assets/insta.jpg",
                          fit: BoxFit.fill,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.cyan,
                            borderRadius: BorderRadius.circular(10)),
                        //color: Colors.red,
                        height: 60, width: 60,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Image.asset(
                          "assets/gmail.jpg",
                          fit: BoxFit.fill,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.cyan,
                            borderRadius: BorderRadius.circular(10)),
                        //color: Colors.red,
                        height: 60, width: 60,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
