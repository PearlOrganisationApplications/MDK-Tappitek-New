import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Const/user_Error.dart';
import '../Model/My_Friend_List_Model.dart';
import '../Utils/app_preferences.dart';
import '../Utils/heder.dart';






class YourFriendList with ChangeNotifier{

  bool _loading = false;
  My_Friend_List? _My_Friend_ListModel;
  UserError? _userError;
  bool _isRejectBooking = false;


  // BookingRequestViewModel (){
  //   getbookingApiCall(true);
  //   notifyListeners();
  // }

  bool get loading => _loading;
  My_Friend_List? get My_Friend_ListModel=> _My_Friend_ListModel;
  UserError? get userError => _userError;
  bool get isRejectBooking => _isRejectBooking;

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }
  setGetBookingModle(My_Friend_List My_Friend_ListModel){
    _My_Friend_ListModel = My_Friend_ListModel;
    notifyListeners();
  }
  setUserError(UserError userError) {
    _userError = userError;
    notifyListeners();
  }

  setRejectBooking(bool data) {
    _isRejectBooking = !data;
    print("_isRejectBooking $_isRejectBooking");
    notifyListeners();
  }

  getbookingApiCall(Email) async{
    //String userId = await LoggedInUserBloc.instance().getUserId();
    setLoading(true);

    List<Friends> friendlist = [];


    var headers = {
      'Authorization': 'Bearer '+"${AppPreferences.getToken()!}"
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://test.pearl-developer.com/mdk/public/api/my-friend-list'));
    request.fields.addAll({
      'email': Email,
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {

      await response.stream.bytesToString().then((value) async {
        var data = await jsonDecode(value);
        //print(data['users']);
        if(data['status'] == "201"){
          //print(data['users']);

          for(var item in data['friends']){
            friendlist.add(Friends.fromJson(item));
            //Users new = Users(data['status'], );
            //print('<------${item}');
          }

          print('<------------${friendlist[0].email}');
        }
      });
    }
    else {
      print(response.reasonPhrase);
    }
    return friendlist;
  }


}



















/*class MyFriendList with ChangeNotifier {
 // List<dynamic> data =




  Future<List<Friends>> myfriendlist(Email) async {
    List<Friends> friendlist = [];


    var headers = {
      'Authorization': 'Bearer '+"${AppPreferences.getToken()!}"
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://test.pearl-developer.com/mdk/public/api/my-friend-list'));
    request.fields.addAll({
      'email': Email,
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {

      await response.stream.bytesToString().then((value) async {
        var data = await jsonDecode(value);
        //print(data['users']);
        if(data['status'] == "201"){
          //print(data['users']);

          for(var item in data['friends']){
            friendlist.add(Friends.fromJson(item));
            //Users new = Users(data['status'], );
            //print('<------${item}');
          }

          print('<------------${friendlist[0].email}');
        }
      });
    }
    else {
      print(response.reasonPhrase);
    }
    return friendlist;
  }
}*/
