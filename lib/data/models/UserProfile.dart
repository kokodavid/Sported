class UserProfile {
  String fullName;
  String email;
  String age;
  String gender;
  String clubA;
  String clubB;
  String clubC;
  String pasteUrl;
  String buddy;
  String coach;
  String uid;
  List<String> sportsPlayed;

  UserProfile({
    this.fullName,
    this.email,
    this.uid,
    this.age,
    this.gender,
    this.clubA,
    this.clubB,
    this.clubC,
    this.pasteUrl,
    this.buddy,
    this.coach,
    this.sportsPlayed,
  });

  Map toMap(UserProfile userProfile) {
    var data = Map<String, dynamic>();
    data["fullName"] = userProfile.fullName;
    data["email"] = userProfile.email;
    data["uid"] = userProfile.uid;
    data["age"] = userProfile.age;
    data["gender"] = userProfile.gender;
    data["clubA"] = userProfile.clubA;
    data["clubB"] = userProfile.clubB;
    data["clubC"] = userProfile.clubC;
    data["pasteUrl"] = userProfile.pasteUrl;
    data["buddy"] = userProfile.buddy;
    data["coach"] = userProfile.coach;
    data["sportsPlayed"] = List<dynamic>.from(sportsPlayed.map((x) => x));
    return data;
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        uid: json["uid"],
        fullName: json["fullName"],
        coach: json["coach"],
        buddy: json["buddy"],
        clubC: json["clubC"],
        clubA: json["clubA"],
        clubB: json["clubB"],
        pasteUrl: json["pasteUrl"],
        gender: json["gender"],
        age: json["age"],
        email: json["email"],
        sportsPlayed: List<String>.from(json["sportsPlayed"]?.map((x) => x)),
      );
}
