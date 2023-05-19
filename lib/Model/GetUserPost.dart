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
  int? likeCount;
  int? commentCount;
  String? createdAt;
  String? updatedAt;
  String? postImage;
  List<UserDetails>? userDetails;

  Posts(
      {this.id,
        this.userId,
        this.image,
        this.text,
        this.likeCount,
        this.commentCount,
        this.createdAt,
        this.updatedAt,
        this.postImage,
        this.userDetails});

  Posts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    image = json['image'];
    text = json['text'];
    likeCount = json['like_count'];
    commentCount = json['comment_count'];
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
    data['like_count'] = this.likeCount;
    data['comment_count'] = this.commentCount;
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
  Null? currentAddress;
  Null? pincode;
  Null? country;
  Null? state;
  Null? city;
  Null? doB;
  Null? gender;
  Null? about;
  String? createdAt;
  String? updatedAt;
  String? profileImage;

  UserDetails(
      {this.id,
        this.name,
        this.phone,
        this.email,
        this.profile,
        this.currentAddress,
        this.pincode,
        this.country,
        this.state,
        this.city,
        this.doB,
        this.gender,
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
    currentAddress = json['current_address'];
    pincode = json['pincode'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    doB = json['DoB'];
    gender = json['Gender'];
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
    data['current_address'] = this.currentAddress;
    data['pincode'] = this.pincode;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['DoB'] = this.doB;
    data['Gender'] = this.gender;
    data['about'] = this.about;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['profile_image'] = this.profileImage;
    return data;
  }
}
