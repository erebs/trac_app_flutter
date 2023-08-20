class FraudsDetailModel {
  String? message;
  bool? status;
  FraudDetails? fraudDetails;

  FraudsDetailModel({this.message, this.status, this.fraudDetails});

  FraudsDetailModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    fraudDetails = json['fraud_details'] != null
        ? new FraudDetails.fromJson(json['fraud_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.fraudDetails != null) {
      data['fraud_details'] = this.fraudDetails!.toJson();
    }
    return data;
  }
}

class FraudDetails {
  int? id;
  int? shopId;
  String? name;
  String? mobileNumber;
  String? address;
  String? profilePhoto;
  String? proofType;
  String? proofNumber;
  String? description;
  Null? approvedBy;
  String? createdAt;
  String? updatedAt;

  FraudDetails(
      {this.id,
        this.shopId,
        this.name,
        this.mobileNumber,
        this.address,
        this.profilePhoto,
        this.proofType,
        this.proofNumber,
        this.description,
        this.approvedBy,
        this.createdAt,
        this.updatedAt});

  FraudDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopId = json['shop_id'];
    name = json['name'];
    mobileNumber = json['mobile_number'];
    address = json['address'];
    profilePhoto = json['profile_photo'];
    proofType = json['proof_type'];
    proofNumber = json['proof_number'];
    description = json['description'];
    approvedBy = json['approved_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shop_id'] = this.shopId;
    data['name'] = this.name;
    data['mobile_number'] = this.mobileNumber;
    data['address'] = this.address;
    data['profile_photo'] = this.profilePhoto;
    data['proof_type'] = this.proofType;
    data['proof_number'] = this.proofNumber;
    data['description'] = this.description;
    data['approved_by'] = this.approvedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
