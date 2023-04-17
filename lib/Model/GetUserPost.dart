class GetUserPost {
  List<Posts>? posts;
  bool? status;

  GetUserPost({this.posts, this.status});

  GetUserPost.fromJson(Map<String, dynamic> json) {
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(new Posts.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.posts != null) {
      data['posts'] = this.posts!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Posts {
  int? id;
  int? userId;
  String? image;
  String? text;
  String? createdAt;
  String? updatedAt;
  String? postImage;
  List<UserDetails>? userDetails;

  Posts(
      {this.id,
        this.userId,
        this.image,
        this.text,
        this.createdAt,
        this.updatedAt,
        this.postImage,
        this.userDetails});

  Posts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    image = json['image'];
    text = json['text'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    postImage = json['post_image'];
    if (json['user_details'] != null) {
      userDetails = <UserDetails>[];
      json['user_details'].forEach((v) {
        userDetails!.add(new UserDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['image'] = this.image;
    data['text'] = this.text;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['post_image'] = this.postImage;
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserDetails {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? profile;
  String? about;
  String? createdAt;
  String? updatedAt;
  String? profileImage;

  UserDetails(
      {this.id,
        this.name,
        this.phone,
        this.email,
        this.profile,
        this.about,
        this.createdAt,
        this.updatedAt,
        this.profileImage});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    profile = json['profile'];
    about = json['about'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['profile'] = this.profile;
    data['about'] = this.about;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['profile_image'] = this.profileImage;
    return data;
  }
}