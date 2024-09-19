class UserModel {
  String? uId;
  String? name;
  String? bio;
  String? email;
  String? phone;
  String? imageUrl;
  String? token;

  UserModel({
    this.uId,
    this.name,
    this.bio,
    this.email,
    this.phone,
    this.imageUrl,
    this.token,
  });

  // Factory method to create an instance from JSON
  factory UserModel.fromJson(Map<Object?, Object?> json) {
    return UserModel(
      uId: json['uId'] as String?,
      email: json['email'] as String?,
      bio: json['bio'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      imageUrl: json['imageUrl'] as String?,
      token: json['token'] as String?,
    );
  }

  // Convert the object to a map
  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'bio': bio,
      'email': email,
      'phone': phone,
      'imageUrl': imageUrl,
      'token': token,
    };
  }
}
