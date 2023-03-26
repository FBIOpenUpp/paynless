class User {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? avatar;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.avatar,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    avatar = json['avatarUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['avatarUrl'] = avatar;
    return data;
  }
}
