class SearchModel {
  bool? status;
  String? message;
  List<Frauds>? frauds;

  SearchModel({this.status, this.message, this.frauds});

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['frauds'] != null) {
      frauds = <Frauds>[];
      json['frauds'].forEach((v) {
        frauds!.add(new Frauds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.frauds != null) {
      data['frauds'] = this.frauds!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Frauds {
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

  Frauds(
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

  Frauds.fromJson(Map<String, dynamic> json) {
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
