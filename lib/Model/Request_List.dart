class Request_List {
  String? msg;
  List<Friends>? friends;
  String? status;

  Request_List({this.msg, this.friends, this.status});

  Request_List.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['friends'] != null) {
      friends = <Friends>[];
      json['friends'].forEach((v) {
        friends!.add(new Friends.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.friends != null) {
      data['friends'] = this.friends!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Friends {
  int? id;
  String? name;
  String? email;
  String? profile;
  String? gender;
  String? city;
  String? state;
  Null? about;
  int? myRequestId;
  String? userEmail;
  String? profileImage;

  Friends(
      {this.id,
        this.name,
        this.email,
        this.profile,
        this.gender,
        this.city,
        this.state,
        this.about,
        this.myRequestId,
        this.userEmail,
        this.profileImage});

  Friends.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    profile = json['profile'];
    gender = json['gender'];
    city = json['city'];
    state = json['state'];
    about = json['about'];
    myRequestId = json['my_request_id'];
    userEmail = json['user_email'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['profile'] = this.profile;
    data['gender'] = this.gender;
    data['city'] = this.city;
    data['state'] = this.state;
    data['about'] = this.about;
    data['my_request_id'] = this.myRequestId;
    data['user_email'] = this.userEmail;
    data['profile_image'] = this.profileImage;
    return data;
  }
}
