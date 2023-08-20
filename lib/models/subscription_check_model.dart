class SubscriptionCheckModel {
  bool? status;
  String? message;
  Subscription? subscription;

  SubscriptionCheckModel({this.status, this.message, this.subscription});

  SubscriptionCheckModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    subscription = json['subscription'] != null
        ? new Subscription.fromJson(json['subscription'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.subscription != null) {
      data['subscription'] = this.subscription!.toJson();
    }
    return data;
  }
}

class Subscription {
  int? id;
  int? userId;
  int? shopId;
  int? transactionId;
  String? plan;
  String? price;
  String? subscriptionStartDate;
  String? subscriptionEndDate;
  String? createdAt;
  String? updatedAt;

  Subscription(
      {this.id,
        this.userId,
        this.shopId,
        this.transactionId,
        this.plan,
        this.price,
        this.subscriptionStartDate,
        this.subscriptionEndDate,
        this.createdAt,
        this.updatedAt});

  Subscription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    shopId = json['shop_id'];
    transactionId = json['transaction_id'];
    plan = json['plan'];
    price = json['price'];
    subscriptionStartDate = json['subscription_StartDate'];
    subscriptionEndDate = json['subscription_EndDate'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['shop_id'] = this.shopId;
    data['transaction_id'] = this.transactionId;
    data['plan'] = this.plan;
    data['price'] = this.price;
    data['subscription_StartDate'] = this.subscriptionStartDate;
    data['subscription_EndDate'] = this.subscriptionEndDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
