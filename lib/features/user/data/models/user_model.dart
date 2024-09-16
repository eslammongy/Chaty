class UserModel {
  String? uId;
  String? name;
  String? bio;
  String? email;
  String? phone;
  String? imageUrl;
  String? password;

  UserModel({
    this.email,
    this.name,
    this.phone,
    this.uId,
    this.imageUrl,
    this.password,
    this.bio,
  });

  UserModel.fromJson(Map<Object?, Object?> json) {
    uId = json['uId'] as String?;
    email = json['email'] as String?;
    bio = json['bio'] as String?;
    name = json['name'] as String?;
    phone = json['phone'] as String?;
    imageUrl = json['imageUrl'] as String?;
    password = json['password'] as String?;
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'bio': bio,
      'email': email,
      'phone': phone,
      'imageUrl': imageUrl,
      'password': password,
    };
  }
}
