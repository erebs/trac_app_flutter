class FraudImageModel {
  bool? status;
  String? message;
  List<String>? images;
  String? appendUrl;

  FraudImageModel({this.status, this.message, this.images, this.appendUrl});

  FraudImageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    images = json['images'].cast<String>();
    appendUrl = json['append_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['images'] = this.images;
    data['append_url'] = this.appendUrl;
    return data;
  }
}