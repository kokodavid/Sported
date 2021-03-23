class UserModel {
  String uid;
  String username;
  String email;
  String avatarUrl;

  UserModel({this.uid, this.username, this.email, this.avatarUrl});

  Map toMap(UserModel user) {
    var data = Map<String, dynamic>();

    data["uid"] = user.uid;
    data["username"] = user.username;
    data["email"] = user.email;
    data["avatar"] = user.avatarUrl;

    return data;
  }

  // UserModel.fromMap(Map<String, dynamic> mapData) {
  //   this.uid = mapData["uid"];
  //   this.username = mapData["username"];
  //   this.email = mapData["email"];
  //   this.avatarUrl = mapData['avatar'];
  // }

}
