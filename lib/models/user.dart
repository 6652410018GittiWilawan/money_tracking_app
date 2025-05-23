class User {
  int? userId;
  String? userFullname;
  String? userBirthDate;
  String? userName;
  String? userPassword;
  String? userImage;

  User({
    this.userFullname,
    this.userBirthDate,
    this.userName,
    this.userPassword,
    this.userImage,
  });

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userFullname = json['userFullname'];
    userBirthDate = json['userBirthDate'];
    userName = json['userName'];
    userPassword = json['userPassword'];
    userImage = json['userImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userFullname'] = this.userFullname;
    data['userBirthDate'] = this.userBirthDate;
    data['userName'] = this.userName;
    data['userPassword'] = this.userPassword;
    data['userImage'] = this.userImage;
    return data;
  }
}