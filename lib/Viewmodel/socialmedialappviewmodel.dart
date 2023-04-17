import 'package:flutter/material.dart';
import '../../repo/api_remote_services.dart';
import '../Const/user_Error.dart';
import '../Model/socialmediaappsmodel.dart';
import '../Utils/Api_collection.dart';
import '../Utils/api_status.dart';

class SocialMediaappViewModel with ChangeNotifier {
  // bool _loading = false;
  // SocialMediaapps? _socialMediaapps;
  // UserError? _userError;
  //
  // bool get loading => _loading;
  //
  // SocialMediaapps? get socialmediaapps => _socialMediaapps;
  //
  // UserError? get userError => _userError;
  //
  // SocialMediaappViewModel() {
  //   socialmediaAPIcall();
  // }
  //
  // setLoading(bool loading) {
  //   _loading = loading;
  //   notifyListeners();
  // }
  //
  // setSocialMediaapps(SocialMediaapps socialMediaapps) {
  //   _socialMediaapps = socialMediaapps;
  //   notifyListeners();
  // }
  //
  // setUserError(UserError userError) {
  //   _userError = userError;
  //   notifyListeners();
  // }

 static  socialmediaAPIcall() async {
  //  setLoading(true);
    //String userId = await LoggedInUserBloc.instance().getUserId();
    // var data = {
    //   "pandit_id": userId
    // };
    var respones = await ApiRemoteServices.fechingGetApi(
        apiUrl: GET_APPS_LINK,);
    // if (respones is Success) {
    //   Object data = socialMediaappsFromJson(respones.response as String);
    //   setSocialMediaapps(data as SocialMediaapps);
    // } else if (respones is Failure) {
    //   UserError userError =
    //   UserError(code: respones.code, message: respones.errorResponse);
    //   setUserError(userError);
    // }
    // setLoading(false);
  }
}