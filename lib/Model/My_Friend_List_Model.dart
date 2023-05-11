class My_Friend_List {
  String? msg;
  List<Friends>? friends;
  String? status;

  My_Friend_List({this.msg, this.friends, this.status});

  My_Friend_List.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? email;
  String? gender;
  String? city;
  String? state;
  Null? about;
  String? profileImage;

  Friends(
      {this.name,
        this.email,
        this.gender,
        this.city,
        this.state,
        this.about,
        this.profileImage});

  Friends.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    gender = json['gender'];
    city = json['city'];
    state = json['state'];
    about = json['about'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['city'] = this.city;
    data['state'] = this.state;
    data['about'] = this.about;
    data['profile_image'] = this.profileImage;
    return data;
  }
}
