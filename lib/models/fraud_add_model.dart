class FraudAddModel {
  bool? status;
  String? message;
  Fraud? fraud;

  FraudAddModel({this.status, this.message, this.fraud});

  FraudAddModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    fraud = json['fraud'] != null ? new Fraud.fromJson(json['fraud']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.fraud != null) {
      data['fraud'] = this.fraud!.toJson();
    }
    return data;
  }
}

class Fraud {
  String? shopId;
  String? name;
  String? mobileNumber;
  String? address;
  String? profilePhoto;
  String? proofType;
  String? proofNumber;
  String? description;
  String? updatedAt;
  String? createdAt;
  int? id;

  Fraud(
      {this.shopId,
        this.name,
        this.mobileNumber,
        this.address,
        this.profilePhoto,
        this.proofType,
        this.proofNumber,
        this.description,
        this.updatedAt,
        this.createdAt,
        this.id});

  Fraud.fromJson(Map<String, dynamic> json) {
    shopId = json['shop_id'];
    name = json['name'];
    mobileNumber = json['mobile_number'];
    address = json['address'];
    profilePhoto = json['profile_photo'];
    proofType = json['proof_type'];
    proofNumber = json['proof_number'];
    description = json['description'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shop_id'] = this.shopId;
    data['name'] = this.name;
    data['mobile_number'] = this.mobileNumber;
    data['address'] = this.address;
    data['profile_photo'] = this.profilePhoto;
    data['proof_type'] = this.proofType;
    data['proof_number'] = this.proofNumber;
    data['description'] = this.description;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
