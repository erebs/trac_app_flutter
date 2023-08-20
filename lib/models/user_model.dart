class UserModel {
  bool? status;
  bool? isActive;
  String? message;
  User? user;
  Shop? shop;

  UserModel({this.status, this.isActive, this.message, this.user, this.shop});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    isActive = json['is_active'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    shop = json['shop'] != null ? new Shop.fromJson(json['shop']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['is_active'] = this.isActive;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.shop != null) {
      data['shop'] = this.shop!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? memberId;
  String? mobileNumber;
  String? pincode;
  String? district;
  String? constituency;
  String? status;
  int? isApproved;
  int? isPresident;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.name,
        this.memberId,
        this.mobileNumber,
        this.pincode,
        this.district,
        this.constituency,
        this.status,
        this.isApproved,
        this.isPresident,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    memberId = json['member_id'];
    mobileNumber = json['mobile_number'];
    pincode = json['pincode'];
    district = json['district'];
    constituency = json['constituency'];
    status = json['status'];
    isApproved = json['is_approved'];
    isPresident = json['is_president'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['member_id'] = this.memberId;
    data['mobile_number'] = this.mobileNumber;
    data['pincode'] = this.pincode;
    data['district'] = this.district;
    data['constituency'] = this.constituency;
    data['status'] = this.status;
    data['is_approved'] = this.isApproved;
    data['is_president'] = this.isPresident;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Shop {
  int? id;
  int? userId;
  String? shopName;
  String? mobileNumber;
  String? gst;
  String? pincode;
  String? district;
  String? constituency;
  String? shopAddress;
  String? status;
  String? createdAt;
  String? updatedAt;

  Shop(
      {this.id,
        this.userId,
        this.shopName,
        this.mobileNumber,
        this.gst,
        this.pincode,
        this.district,
        this.constituency,
        this.shopAddress,
        this.status,
        this.createdAt,
        this.updatedAt});

  Shop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    shopName = json['shop_name'];
    mobileNumber = json['mobile_number'];
    gst = json['gst'];
    pincode = json['pincode'];
    district = json['district'];
    constituency = json['constituency'];
    shopAddress = json['shop_address'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['shop_name'] = this.shopName;
    data['mobile_number'] = this.mobileNumber;
    data['gst'] = this.gst;
    data['pincode'] = this.pincode;
    data['district'] = this.district;
    data['constituency'] = this.constituency;
    data['shop_address'] = this.shopAddress;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
