class Shop {
  String? name;
  String? upiId;
  String? address;
  String? phone;
  String? email;
  double? lat;
  double? lng;
  String? id;
  List<String>? paymentMethods;

  Shop({
    this.name,
    this.upiId,
    this.address,
    this.phone,
    this.email,
    this.lat,
    this.lng,
    this.id,
    this.paymentMethods,
  });

  Shop.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    upiId = json['upi_id'];
    address = json['address'];
    phone = json['phone'];
    email = json['email'];
    lat = json['lat'];
    lng = json['lng'];
    id = json['id'];
    paymentMethods = json['payment_methods'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['upi_id'] = upiId;
    data['address'] = address;
    data['phone'] = phone;
    data['email'] = email;
    data['lat'] = lat;
    data['lng'] = lng;
    data['id'] = id;
    data['payment_methods'] = paymentMethods;
    return data;
  }
}
