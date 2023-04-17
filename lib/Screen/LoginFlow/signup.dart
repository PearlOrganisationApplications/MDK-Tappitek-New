import 'dart:io';

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:dob_input_field/dob_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:gender_picker/source/enums.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../Utils/app_preferences.dart';
import 'SignIn.dart';
import '../homescreen.dart';
class signupscreen extends StatefulWidget {
  const signupscreen({Key? key}) : super(key: key);

  @override
  State<signupscreen> createState() => _signupscreenState();
}

class _signupscreenState extends State<signupscreen> {


  late String countryValue;
  late String stateValue;
  late String cityValue;
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
                            //color: kPrimaryColor,
                            size: 50,
                          ),
                        ),
                      ),
                      Container(
                        // width: wt * 0.30,
                        // height: ht * 0.20,
                        decoration:  BoxDecoration(
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
                              //color: kPrimaryColor,
                              size: 50,
                            )),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "OPENCAMERA",
                        style: GoogleFonts.poppins(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "OPENFILE",
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



  var _email = '';
  var _password = '';
  var _confirmPassword = '';

/*  void signUpUser() async {
    if (_password != _confirmPassword){ // you can add your statements here
      Fluttertoast.showToast(msg: "Password does not match. Please re-type again.");
    }

    // else if (response.statusCode == 400) {
    //   Fluttertoast.showToast(msg: "already registerd");
    // }

    else {
      Fluttertoast.showToast(msg: "You are registerd successfuly. You can login now");

      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  signinscreen())
      );

      // FirebaseAuthMethods(FirebaseAuth.instance).signUpWithEmail(
      //   email: emailController.text,
      //   password: passwordController.text,
      //   context: context,
      // );
    }
  }*/


  TextEditingController emailController =   TextEditingController();
  TextEditingController phoneController =   TextEditingController();
  TextEditingController nameController =   TextEditingController();
  bool _validate = false;
  TextEditingController passwordController =  TextEditingController();
  TextEditingController confirmpasswordController =  TextEditingController();
  TextEditingController dateInputController = TextEditingController();

/*  Future loginc( email , password) async {

    try{

      Response response = await post(
          Uri.parse('https://test.pearl-developer.com/mdk/public/api/signin_up'),
          body: {
            'email' : email,
            'password' : password
          }
      );

      if(response.statusCode == 200){

        var data = jsonDecode(response.body);
        print(data['token']);
        print('Login successfully');

      }else {
        print('failed');
      }
    }catch(e){
      print(e);
    }
  }*/

  Future login( name,phone,email,password,)async{
    try{

      //var request = http.MultipartRequest('POST', Uri.parse('https://test.pearl-developer.com/mdk/public/api/signup'));
      /*     request.fields.addAll({
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
        'image_ext': '.png'
      });*/

      var body = json.encode({
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
        'image_ext': '.png'
      });
      var  url = "https://test.pearl-developer.com/mdk/public/api/signup";
      var response= await http.post(Uri.parse(url),headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },

        body: body,
      );

      /*  Response response = await post(
          Uri.parse('https://test.pearl-developer.com/mdk/public/api/signup'),
          body: {
            'email' : emailController,
            'password' : passwordController,
            'name': 'govind rajpoot',
            'phone': '7500620349',
            'image_ext': '.png'
          }
      );*/
      // http.StreamedResponse response = await request.send();



      if (response.statusCode == 201) {
        var data = jsonDecode(response.body);
        print("token id "+data['token']);
        print('Login successfully');
        //print("Govind>>>>>"+await response.stream.bytesToString());
        print("Govind   "+response.toString());
        Fluttertoast.showToast(msg: "registerd");
        AppPreferences.saveToken(token: data['token']);
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  HomeScreen()));

      }
      else if (response.statusCode == 400) {
        Fluttertoast.showToast(
            msg: "Already registerd",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.black,
            backgroundColor: Colors.red,
            fontSize: 16.0
        );
      }

      else {
        Fluttertoast.showToast(msg: "Internal server error");

        print("status code signup""${response.statusCode}");
        print("testinggg"+response.reasonPhrase.toString());
        print('failedd');
      }
    }
    catch(e){
      print(e);
    }
  }




  final textFieldFocusNode = FocusNode();
  final textFieldFocus = FocusNode();
  bool _obscured = true;
  bool _obscuredq = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus = false;     // Prevents focus if tap on eye
    });
  }

  void _toggleObscuredpassword() {
    setState(() {
      _obscuredq = !_obscuredq;
      if (textFieldFocus.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
      textFieldFocus.canRequestFocus = false;     // Prevents focus if tap on eye
    });
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body:
          SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.only(left: 16,right: 16,top: 40,),
              child: Column(
                children: [

                  Text("Sign Up",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 24),),

                  SizedBox(height: 10,),

                  Stack(children: [
                    CircleAvatar(
                      radius: 70,
                      // borderRadius: BorderRadius.circular(100),
                      child: InkWell(
                        //onTap: imagePickerOption,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child:
                          pickedpic != null
                              ? Image.file(
                            pickedpic!,
                            width: 170,
                            height: 170,
                            fit: BoxFit.cover,
                          )
                              : ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              //onTap: imagePickerOption,
                              child: Image.network("https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",height: 170,width: 170,fit: BoxFit.fill,)

                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 20,
                      right: 0,
                      child: InkWell(
                        onTap: imagePickerOption,
                        child: Icon(Icons.camera_alt,color: Colors.black,size: 30,),
                      ),
                    ),

                  ],),

                  SizedBox(height: 15,),

//Email ID  Field
                  TextField(
                    controller: emailController,
                    onChanged: (value) {
                      _email = value;
                    },
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never, //Hides label on focus or if filled
                      labelText: "Email ID",
                      errorText: _validate ? 'Value Can\'t Be Empty' : null,

                      filled: true, // Needed for adding a fill color
                      //fillColor: Colors.grey.shade800,
                      isDense: true,  // Reduces height a bit
                      border: OutlineInputBorder(
                        // borderSide: BorderSide.none,              // No border
                        borderRadius: BorderRadius.circular(12),  // Apply corner radius
                      ),
                      prefixIcon: Icon(Icons.person, size: 24),
                    ),
                  ),
                  SizedBox(height: 10,),
//Name field
                  TextField(
                    controller: nameController,
                    onChanged: (value) {
                      _email = value;
                    },
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never, //Hides label on focus or if filled
                      labelText: "Name",
                      errorText: _validate ? 'Value Can\'t Be Empty' : null,
                      filled: true, // Needed for adding a fill color
                      //fillColor: Colors.grey.shade800,
                      isDense: true,  // Reduces height a bit
                      border: OutlineInputBorder(
                        // borderSide: BorderSide.none,              // No border
                        borderRadius: BorderRadius.circular(12),  // Apply corner radius
                      ),
                      prefixIcon: Icon(Icons.person, size: 24),
                    ),
                  ),
                  SizedBox(height: 10,),
//Phone
                  TextField(
                    controller: phoneController,
                    onChanged: (value) {
                      _email = value;
                    },
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never, //Hides label on focus or if filled
                      labelText: "Phone",
                      errorText: _validate ? 'Value Can\'t Be Empty' : null,

                      filled: true, // Needed for adding a fill color
                      //fillColor: Colors.grey.shade800,
                      isDense: true,  // Reduces height a bit
                      border: OutlineInputBorder(
                        // borderSide: BorderSide.none,              // No border
                        borderRadius: BorderRadius.circular(12),  // Apply corner radius
                      ),
                      prefixIcon: Icon(Icons.person, size: 24),
                    ),
                  ),
                  SizedBox(height: 10,),
//Phone

                  IntlPhoneField(
                    decoration: InputDecoration(
                      //labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(),
                      ),
                    ),
                    initialCountryCode: 'IN',
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                  ),
                  SizedBox(height: 10,),

// Current Address
                  TextField(
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never, //Hides label on focus or if filled
                      labelText: "Current address",
                      // errorText: _validate ? 'Value Can\'t Be Empty' : null,
                      // filled: true, // Needed for adding a fill color
                      //fillColor: Colors.grey.shade800,
                      //isDense: true,  // Reduces height a bit
                      border: OutlineInputBorder(
                        // borderSide: BorderSide.none,              // No border
                        borderRadius: BorderRadius.circular(12),  // Apply corner radius
                      ),
                      prefixIcon: Icon(Icons.location_searching_outlined, size: 24),
                    ),
                  ),
                  SizedBox(height: 10,),
//PIN code
                  TextField(
                    keyboardType: TextInputType.phone,
                    //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never, //Hides label on focus or if filled
                      labelText: "PIN code",
                      // errorText: _validate ? 'Value Can\'t Be Empty' : null,
                      // filled: true, // Needed for adding a fill color
                      //fillColor: Colors.grey.shade800,
                      //isDense: true,  // Reduces height a bit
                      border: OutlineInputBorder(
                        // borderSide: BorderSide.none,              // No border
                        borderRadius: BorderRadius.circular(12),  // Apply corner radius
                      ),
                      prefixIcon: Icon(Icons.pin, size: 24),
                    ),
                  ),
                  SizedBox(height: 10,),
// country state city
                  Container(

                      padding: EdgeInsets.symmetric(horizontal: 20),
                      //height: 600,
                      decoration: BoxDecoration(
                        //color: Colors.cyan,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child:
                      Column(
                        children: [

                          SelectState(
                            // style: TextStyle(color: Colors.red),
                            onCountryChanged: (value) {
                              setState(() {
                                countryValue = value;
                              });
                            },
                            onStateChanged:(value) {
                              setState(() {
                                stateValue = value;
                              });
                            },
                            onCityChanged:(value) {
                              setState(() {
                                cityValue = value;
                              });
                            },

                          ),
                          // InkWell(
                          //     onTap:(){
                          //       print('country selected is $countryValue');
                          //       print('country selected is $stateValue');
                          //       print('country selected is $cityValue');
                          //     },
                          //     child: Text(' Check')
                          // )
                        ],
                      )
                  ),


                  SizedBox(height: 10,),
//DOB
                  TextFormField(

                    decoration:  InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            width: 3, color: Colors.greenAccent), //<-- SEE HERE
                      ),
                      // border: InputBorder.none,
                      //label: "DOB",
                      labelText: "DOB",
                      hintText: 'DOB',
                      prefixIcon: Icon(Icons.calendar_month,color: Colors.black,),

                    ),
                    controller: dateInputController,
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2050));

                      if (pickedDate != null) {
                        dateInputController.text =
                            DateFormat('dd MMMM yyyy').format(pickedDate);
                      }
                    },
                  ),


                  SizedBox(height: 10,),
//Gender Option
                  Container(
                    height:60,
                    decoration: BoxDecoration(
                      //color: Colors.cyan,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12)
                    ),

                    child: GenderPickerWithImage(
                      showOtherGender: true,
                      verticalAlignedText: false,
                      selectedGender: Gender.Male,
                      selectedGenderTextStyle: TextStyle(
                          color: Color(0xFF8b32a8), fontWeight: FontWeight.bold),
                      unSelectedGenderTextStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.normal),
                      onChanged: (Gender? gender) {
                        print(gender);
                      },
                      equallyAligned: true,
                      animationDuration: Duration(milliseconds: 300),
                      isCircular: true,
                      // default : true,
                      opacityOfGradient: 0.4,
                      padding: const EdgeInsets.all(3),
                      size: 50, //default : 40
                    ),
                  ),
                  SizedBox(height: 10,),

//Password
                  TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _obscured,
                    onChanged: (value) {
                      _password = value;
                    },// N
                    focusNode: textFieldFocusNode,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never, //Hides label on focus or if filled
                      labelText: "Password",
                      filled: true, // Needed for adding a fill color
                      //fillColor: Colors.grey.shade800,
                      isDense: true,  // Reduces height a bit
                      border: OutlineInputBorder(
                        // borderSide: BorderSide.none,              // No border
                        borderRadius: BorderRadius.circular(12),  // Apply corner radius
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
                  SizedBox(height: 10,),
//Confirm password
                  TextField(
                    controller: confirmpasswordController,

                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _obscuredq,

                    onChanged: (value) {
                      _confirmPassword = value;
                    },// N
                    focusNode: textFieldFocus,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never, //Hides label on focus or if filled
                      labelText: "Confirm Password",
                      filled: true, // Needed for adding a fill color
                      //fillColor: Colors.grey.shade800,
                      isDense: true,  // Reduces height a bit
                      border: OutlineInputBorder(
                        // borderSide: BorderSide.none,              // No border
                        borderRadius: BorderRadius.circular(12),  // Apply corner radius
                      ),
                      prefixIcon: Icon(Icons.lock_rounded, size: 24),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                        child: GestureDetector(
                          onTap: _toggleObscuredpassword,
                          child: Icon(
                            _obscuredq
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10,),

//sign up button
                  SizedBox(
                    height: 55,
                    width: double.infinity,
                    child:
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

                          setState(() {
                            emailController.text.isEmpty ? _validate = true : _validate = false;
                          });

                        //  login(nameController.text.toString(),phoneController.text.toString(),emailController.text.toString(), passwordController.text.toString());


                          showVerificationDialog(context);

                        },
                        child:  Text("Sign Up",style: TextStyle(color: Colors.black),)
                    ),
                  ),
                  SizedBox(height: 24 ),

                  Row(
                      children: <Widget>[
                        Expanded(
                            child: Divider(thickness: 1.5,)
                        ),
                        SizedBox(width: 5,),
                        Text("Or sign up with",style: TextStyle(fontWeight: FontWeight.w500,color: Color(0xffA29EB6),fontSize: 16),),
                        SizedBox(width: 5,),
                        Expanded(
                            child: Divider(thickness: 1.5,)
                        ),
                      ]
                  ),


                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Container(
                        child: Image.asset("assets/fb.jpg",fit:BoxFit.fill,),
                        decoration: BoxDecoration(
                            color: Colors.cyan,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        //color: Colors.red,
                        height: 60,width: 60,
                      ),
                      SizedBox(width: 10,),
                      Container(
                        child: Image.asset("assets/insta.jpg",fit:BoxFit.fill,),
                        decoration: BoxDecoration(
                            color: Colors.cyan,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        //color: Colors.red,
                        height: 60,width: 60,
                      ),
                      SizedBox(width: 10,),
                      Container(
                        child: Image.asset("assets/gmail.jpg",fit:BoxFit.fill,),
                        decoration: BoxDecoration(
                            color: Colors.cyan,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        //color: Colors.red,
                        height: 60,width: 60,
                      ),
                    ],),

                ],
              ),
            ),
          )
      ),
    );

  }


  showVerificationDialog(BuildContext context,) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return showModalBottomSheet<void>(
      backgroundColor: const Color(0xfff1f1f1),
      // context and builder are
      // required properties in this widget+
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0)),
      ),
      context: context,
      builder: (context1) {
        // we set up a container inside which
        // we create center column and display text
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                "Enter verification code recieved on your Email/Phone number",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(fontSize: 25,fontWeight: FontWeight.w500),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(30),
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  FilteringTextInputFormatter.digitsOnly

                ],
                decoration: InputDecoration(
                  //floatingLabelBehavior: FloatingLabelBehavior.never, //Hides label on focus or if filled
                  labelText: "Verification code",
                  border: OutlineInputBorder(
                    // borderSide: BorderSide.none,              // No border
                    borderRadius: BorderRadius.circular(12),  // Apply corner radius
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35,right: 35),
              child: SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all( Color(0xff0EBEAA)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              // side: BorderSide(color: Colors.red)
                            )
                        )
                    ),
                    onPressed: (){
                      login(nameController.text.toString(),phoneController.text.toString(),emailController.text.toString(), passwordController.text.toString());


                     // Navigator.push(context, MaterialPageRoute(builder: (context) =>  HomeScreen()));
                    },
                    child:  Text("Confirm",style: TextStyle(color: Colors.white,fontSize: 20),)
                ),
              ),
            ),

          ],
        );
      },
    );
  }

}


