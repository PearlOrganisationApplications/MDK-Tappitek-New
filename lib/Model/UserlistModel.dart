class Userlist {
  String? status;
  List<Users>? users;

  Userlist({this.status, this.users});

  Userlist.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  int? id;
  String? name;
  String? email;
  String? profile;
  String? gender;
  String? city;
  String? state;
  Null? about;
  String? profileImage;

  Users(
      {this.id,
        this.name,
        this.email,
        this.profile,
        this.gender,
        this.city,
        this.state,
        this.about,
        this.profileImage});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    profile = json['profile'];
    gender = json['gender'];
    city = json['city'];
    state = json['state'];
    about = json['about'];
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
    data['profile_image'] = this.profileImage;
    return data;
  }
}