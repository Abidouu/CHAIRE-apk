

class User {
  String? userId;
  String? usermail;
  String? userPw;
  String? firstname;
  String? lastname;

  User({
    this.userId,
    this.usermail,
    this.userPw,
    this.firstname,
    this.lastname,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'] ,
      usermail: json['usermail'] ,
      userPw: json['userPw'] ,
      firstname: json['firstname'],
      lastname: json['lastname'],

    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['usermail'] = usermail;
    data['userPw'] = userPw;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    return data;
  }
}
