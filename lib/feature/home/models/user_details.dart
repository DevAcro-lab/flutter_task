class UserDetails {
  String? status;
  String? message;
  Data? data;

  UserDetails({this.status, this.message, this.data});

  UserDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? phone;
  String? avatar;
  int? earnings;
  String? role;
  String? status;
  String? isVerified;
  String? joinedAt;
  String? ratings;
  String? bio;

  Data(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.gender,
      this.phone,
      this.avatar,
      this.earnings,
      this.role,
      this.status,
      this.isVerified,
      this.joinedAt,
      this.ratings,
      this.bio});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    gender = json['gender'];
    phone = json['phone'];
    avatar = json['avatar'];
    earnings = json['earnings'];
    role = json['role'];
    status = json['status'];
    isVerified = json['is_verified'];
    joinedAt = json['joined_at'];
    ratings = json['ratings'];
    bio = json['bio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['gender'] = gender;
    data['phone'] = phone;
    data['avatar'] = avatar;
    data['earnings'] = earnings;
    data['role'] = role;
    data['status'] = status;
    data['is_verified'] = isVerified;
    data['joined_at'] = joinedAt;
    data['ratings'] = ratings;
    data['bio'] = bio;
    return data;
  }
}
