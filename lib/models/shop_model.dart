class ShopModel {
  bool? status;
  String? message;
  List<Shops>? shops;

  ShopModel({this.status, this.message, this.shops});

  ShopModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['shops'] != null) {
      shops = <Shops>[];
      json['shops'].forEach((v) {
        shops!.add(new Shops.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.shops != null) {
      data['shops'] = this.shops!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shops {
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

  Shops(
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

  Shops.fromJson(Map<String, dynamic> json) {
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
