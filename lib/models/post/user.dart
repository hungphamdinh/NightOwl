class User {
  dynamic? googleUserId;
  dynamic? id;
  String? name;
  String? mail;
  String? role;
  String? profile;
  // Object? members;

  User(
      {this.googleUserId,
      this.id,
      this.name,
      this.mail,
      this.role,
      this.profile,
      });

  factory User.fromMap(Map<String, dynamic> json) => User(
        googleUserId: json["googleUserId"],
        id: json["id"],
        name: json["name"],
        mail: json["mail"],
        role: json['role'],
        profile: json['profile'],
      );

  Map<String, dynamic> toMap() => {
        "googleUserId": googleUserId,
        "id": id,
        "name": name,
        "mail": mail,
        "role": role,
        "profile": profile,
      };
}
