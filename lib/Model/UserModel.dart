class UserModel {
  final String id;
  final String email;
  final String name;
  final String? gender;
  final String? country;
  final String? occupation;
  final String? contact;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.gender,
    this.country,
    this.occupation,
    this.contact,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      gender: json['gender']??"",
      country: json['country']??"",
      occupation: json['occupation']??"",
      contact: json['contact']??"",
    );
  }
}
